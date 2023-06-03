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
            requestContentInitialState()
            return
        }
    }

    lazy var goToDetailContent: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToContentDetail(with: data)
    }
    
    // Start view
    func requestContentInitialState() {
        controller?.startLoading()
        currentSearchValue = nil
        selectedFilterOption = nil
        currentPage = .zero
        requestContent(params: RequestParams(sincePage: currentPage, layoutView: .listContentLayoutCard))
    }
    
    // Next paginate
    func requestNextPage() {
        requestContent(params: RequestParams(search: currentSearchValue,
                                             filterSinceYear: selectedFilterOption,
                                             sincePage: getNextPage(),
                                             layoutView: .listContentLayoutCard))
    }
    
    // Pull to refresh
    func updateContentFromStartPage() {
        currentPage = 0
        requestContent(params: RequestParams(search: currentSearchValue,
                                             filterSinceYear: selectedFilterOption,
                                             sincePage: currentPage,
                                             layoutView: .listContentLayoutCard))
    }
    
    func updateContent() {
        requestContentInitialState()
    }
    
    func requestContent(params: RequestParams?) {
        
        guard let params = params else {
            return
        }
        network?.requestContentWith(param: params) { response in
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
        
        if currentPage == 0 {
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
    
    func nextPage() {
        requestNextPage()
    }
    
    // MARK: - SearchHandlerEvents
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentSearchValue = searchBar.text
        updateContentFromStartPage()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        controller?.disableSearch()
        currentSearchValue = nil
        requestContentInitialState()
    }
    
    // MARK: YearFilterDelegate
    func receiveFilter(value: Int?) {
        selectedFilterOption = value
        updateContentFromStartPage()
    }
}
