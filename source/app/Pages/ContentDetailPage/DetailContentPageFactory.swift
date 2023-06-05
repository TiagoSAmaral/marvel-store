//
//  PageFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class DetailContentPageFactory: FactoryPage {
    
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {
        let controller = ListContentPageController()
        let network = NetworkRequestContent()
        let viewModel = ListContentPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        viewModel.selectedItem = model
        viewModel.currentViewModelStrategy = .detail
        let mosaicComposerView = ViewMosaicComposer()
        
        let listView = TableViewAutomaticPaginate()
        listView.dataHandler = viewModel
        listView.cardFactory = CardMaker()
        mosaicComposerView.insertNew(view: listView)
        controller.listView = listView
        
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadDetailOfItem
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.searchHandlerEvents = viewModel
        controller.view = mosaicComposerView.baseView
        return controller
    }
}
