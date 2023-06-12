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
        let viewModel = ListContentPageViewModel()
        let mosaicComposerView = ViewMosaicComposer()
        let listView = TableViewAutomaticPaginate()
        let cardMaker = CardMaker()
        
        viewModel.controller = controller
        viewModel.network = network
        viewModel.coordinator = coordinator as? ListContentCoordinable
        viewModel.selectedItem = model
        viewModel.currentViewModelStrategy = .detail

        listView.dataHandler = viewModel
        listView.cardFactory = cardMaker
        mosaicComposerView.insertNew(view: listView)
        
        coordinator?.rootViewControler = controller
        
        controller.listView = listView
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadDetailOfItem
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.searchHandlerEvents = viewModel
        controller.title = LocalizedText.with(tagName: .preview)
        controller.view = mosaicComposerView.baseView
        
        return controller
    }
}
