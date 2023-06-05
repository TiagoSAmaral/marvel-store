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
        let viewModel = ListContentPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        
        let mosaicComposerView = ViewMosaicComposer()
        
        let filterYearView = YearSelectorView()
        filterYearView.define(delegate: viewModel, displayerView: mosaicComposerView.baseView)
        mosaicComposerView.insertNew(view: filterYearView)

        let listView = TableViewAutomaticPaginate(isPullToRefreshEnable: true,
                                                  isPaginateEnable: true)
        listView.dataHandler = viewModel
        listView.cardFactory = CardMaker()
        mosaicComposerView.insertNew(view: listView)
        controller.listView = listView
        
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadStoreItems
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.searchController = searchBarController
        controller.searchHandlerEvents = viewModel
        controller.view = mosaicComposerView.baseView
        return controller
    }
}
