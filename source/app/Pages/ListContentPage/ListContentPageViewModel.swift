//
//  PageViewModel.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListContentPageViewModel: NSObject, ViewModelHandlerEventsControllerDelegate, ListDataHandler, SearchHandlerEvents {
    
    weak var controller: ListContentController?
    var network: NetworkContentOperation?
    var coordinator: ListContentCoordinable?
    var lastRequestResult: GeneralResult<Comic>?
    var items: [Comic] = []
    var currentPage: Int?
    var currentSearchValue: String?
    var selectedFilterOption: Int?
    var filterOptions: [Int]?
    let numberOfSection: Int = 1
    
    init(controller: ListContentController, network: NetworkContentOperation, coordinator: Coordinator?) {
        self.controller = controller
        self.network = network
        self.coordinator = coordinator as? ListContentCoordinable
    }
    
    func viewDidAppear() {
        
        guard !items.isEmpty else {
            controller?.startLoading()
            requestContentInitialState()
            return
        }
    }

    lazy var goToDetailContent: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToContentDetail(with: data)
    }
    
    func requestContentInitialState() {
        requestContent(by: nil, filter: nil, page: nil)
    }
    
    func requestNextPage() {
        requestContent(by: currentSearchValue, filter: selectedFilterOption, page: getNextPage())
    }
    
    func requestContent(by text: String?, filter: Int?, page: Int?) {
        network?.requestContentWith(search: text, filter: selectedFilterOption, page: currentPage) { response in
            DispatchQueue.main.async { [weak self] in
                
                switch response {
                case .success(let genericResponse):
                    self?.controller?.stopLoading(onFinish: nil)
                    self?.updateView(with: genericResponse)
                case .failure(let error):
                    self?.controller?.stopLoading {
                        self?.controller?.presentAlert(with: nil, and: error.message, handler: nil)
                    }
                }
                
                self?.controller?.stopLoading(onFinish: nil)
            }
        }
    }
    
    func updateView(with value: Model?) {
        
        guard let value = value as? GeneralResult<Comic>,
              let results = value.data?.results else {
            return
        }
        
        if items.isEmpty {
            items = results
        } else {
            items.append(contentsOf: results)
        }
        currentPage = lastRequestResult?.data?.offset
        lastRequestResult = value
        controller?.updateView()
    }
    
    func getNextPage() -> Int? {
        guard let currentOffset = lastRequestResult?.data?.offset,
              let limit = lastRequestResult?.data?.limit else {
            return nil
        }
        
        let nextPage = currentOffset + 1
        let finalLimit = limit + 1
        if nextPage < finalLimit {
            return nextPage
        }
        return nil
    }
    
    func updateContent() {
        requestContent(by: nil, filter: nil, page: nil)
    }
    
// MARK: - ListDataHandler methods
    
    func numberOfItemsBy(section: Int?) -> Int {
        items.count
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        var item = items[indexPath.row]
        item.action = goToDetailContent
        return item
    }
    
    // MARK: - SearchHandlerEvents
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        controller?.removeDisableSearchbar()
        controller?.startLoading()
        
        currentSearchValue = searchBar.text
        requestContent(by: searchBar.text, filter: selectedFilterOption, page: currentPage)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        controller?.startLoading()
        currentSearchValue = nil
        items.removeAll()
        requestContentInitialState()
    }
}
