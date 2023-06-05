//
//  PageViewModel.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

enum CurrentViewmModelStrategy {
    case store
    case favorite
    case cart
    case detail
}

class ListContentPageViewModel: NSObject,
                                    ViewModable,
                                    ListDataHandler,
                                    SearchHandlerEvents,
                                    YearSelectorViewDataHandlerDelegate {

    weak var controller: ListContentController?
    var network: NetworkContentOperation?
    var coordinator: ListContentCoordinable?
    var lastRequestResult: GeneralResult<Comic>?
    var selectedItem: Model?
    var items: [Model] = []
    var currentPage: Int?
    var currentSearchValue: String?
    var selectedFilterOption: String?
    var filterOptions: [Int]?
    let numberOfSection: Int = 1
    var currentViewModelStrategy: CurrentViewmModelStrategy = .store
    
    // MARK: - ListyearFilter
    var listYearFilter: [String]?
    var disableFilterOptions: String?
    
    init(controller: ListContentController, network: NetworkContentOperation?, coordinator: Coordinator?) {
        super.init()
        self.controller = controller
        self.network = network
        self.coordinator = coordinator as? ListContentCoordinable
        generateFilterYearList()
        registerFilterCancelationValue()
    }
    
    func loadDetailOfItem() {
        guard selectedItem == nil else {
            requestDetail(with: selectedItem)
            return
        }
    }
    
    func loadStoreItems() {
        guard !items.isEmpty else {
            requestContentInitialState()
            return
        }
    }
    
    // MARK: - Actions activated by view interaction
    
    lazy var goToDetailContent: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToContentDetail(with: data)
    }
    
    lazy var saveToFavorite: (Model?) -> Void = {[weak self] comic in
        ComicFavoriteStorage.main.save(comic: comic)
        // TODO: Alert Add to Favorite
        self?.loadFavoritesItems()
        self?.checkIfFavoriteAndCartList()
    }
    
    lazy var removeFavorite: (Model?) -> Void = {[weak self] comic in
        ComicFavoriteStorage.main.remove(comic: comic)
        // TODO: Alert Remove from Favorite
        self?.loadFavoritesItems()
        self?.checkIfFavoriteAndCartList()
    }
    
    lazy var saveToCart: (Model?) -> Void = {[weak self] comic in
        ComicCartStorage.main.save(comic: comic)
        // TODO: Alert Add to Cart
        self?.loadCartItems()
        self?.checkIfFavoriteAndCartList()
    }
    
    lazy var removeFromCart: (Model?) -> Void = { [weak self] comic in
        ComicCartStorage.main.remove(comic: comic)
        // TODO: Alert Remove from Cart
        self?.loadCartItems()
        self?.checkIfFavoriteAndCartList()
    }
    
    // MARK: - Request configurations
    func registerFilterCancelationValue() {
        self.disableFilterOptions = "Todos"
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
        if let nextPageValue = getNextPage() {
            requestContent(params: RequestParams(search: currentSearchValue,
                                                 filterSinceYear: selectedFilterOption,
                                                 sincePage: nextPageValue,
                                                 layoutView: .listContentLayoutCard))
        }
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
    
    func requestDetail(with item: Model?) {
        currentPage = 0
        requestContent(params: RequestParams(identifier: (item as? ViewModelBehavior)?.identifier, layoutView: .detailContentLayoutCard))
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
        
        checkIfFavoriteAndCartList()
        currentPage = lastRequestResult?.data?.offset
        lastRequestResult = value
        controller?.updateView()
    }

    func checkIfFavoriteAndCartList() {
        // When show detail, check if item from API is saved how favorite or cart list
        if items.count == 1, currentViewModelStrategy == .detail {
            ComicCartStorage.main.isPurchable(item: items.first)
            ComicFavoriteStorage.main.isFavorite(item: items.first)
        }
    }
    
    func getNextPage() -> Int? {
        guard let currentOffset = lastRequestResult?.data?.offset,
              let totalPages = lastRequestResult?.data?.total,
              let limitItemPerPage = lastRequestResult?.data?.limit else {
            return nil
        }
        
        let nextPage = currentOffset + limitItemPerPage
                if nextPage < totalPages {
            return nextPage
        }
        
        return nil
    }
    
    // MARK: - Request content from local storage
    func loadFavoritesItems() {
        guard let items = ComicFavoriteStorage.main.listComics(),
              currentViewModelStrategy == .favorite else {
            return
        }
        self.items = items // items.compactMap({ $0 as Model })
        controller?.updateView()
    }
    
    func loadCartItems() {
        guard let items = ComicCartStorage.main.listComics(),
              currentViewModelStrategy == .cart else {
            return
        }
        self.items = items
        controller?.updateView()
    }
    
// MARK: - ListDataHandler methods
    func numberOfItemsBy(section: Int?) -> Int {
        items.count
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        guard var item = items[indexPath.row] as? ViewModelBehavior else {
            return nil
        }
        
        item.selectAction = goToDetailContent
        
        item.addCartAction = saveToCart
        item.removeCartAction = removeFromCart
        
        item.addFavoriteAction = saveToFavorite
        item.removeFavoriteAction = removeFavorite
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
     
     func receive(value: String?) {
         guard value != disableFilterOptions else {
             selectedFilterOption = nil
             requestContentInitialState()
             return
         }
         selectedFilterOption = value
         updateContentFromStartPage()
     }
     
    func generateFilterYearList() {
        
        if listYearFilter == nil {
            let currentYear: Int = Calendar.current.component(.year, from: Date())
            listYearFilter = []
            
            for yearItem in (1938...currentYear) {
                listYearFilter?.append("\(yearItem)")
            }
            listYearFilter?.insert("Todos", at: 0)
        }
    }
}
