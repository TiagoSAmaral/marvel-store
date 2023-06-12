//
//  PageFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListContentPageFactory: FactoryPage {
    
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {

        let controller = ListContentPageController()
        let searchBarController = SearchBarFactory.makeSearch()
        let network = NetworkRequestContent()
        let viewModel = ListContentPageViewModel()
        let mosaicComposerView = ViewMosaicComposer()
        let filterYearView = YearSelectorView()
        let listView = TableViewAutomaticPaginate(isPullToRefreshEnable: true, isPaginateEnable: true)
        let cardMaker = CardMaker()
        
        viewModel.coordinator = coordinator as? ListContentPageCoordinator
        viewModel.controller = controller
        viewModel.network = network
        viewModel.localStorageCartItems = ComicCartStorage()
        viewModel.localStorageFavoriteItems = ComicFavoriteStorage()
        
        filterYearView.define(delegate: viewModel, displayerView: mosaicComposerView.baseView)
        mosaicComposerView.insertNew(view: filterYearView)
        
        listView.dataHandler = viewModel
        listView.cardFactory = cardMaker
        mosaicComposerView.insertNew(view: listView)
        
        coordinator?.rootViewControler = controller

        controller.listView = listView
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadStoreItems
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.searchController = searchBarController
        controller.searchHandlerEvents = viewModel
        controller.view = mosaicComposerView.baseView
        return controller
    }
}
