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
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = ListContentPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        viewFactory.cardFactory = CardMaker()
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewFactory = viewFactory
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.searchController = searchBarController
        controller.searchHandlerEvents = viewModel
        controller.dataHandler = viewModel
        return controller
    }
}
