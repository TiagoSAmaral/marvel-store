//
//  PageFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListUsersPageFactory: FactoryPage {
    
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {

        let controller = ListUserPageController()
        let searchBarController = SearchBarFactory.makeSearch()
//        let headerMaker = NetworkHeaderMaker()
        let network = NetworkUserInfo(headerFactory: nil)
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = ListUsersPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        viewFactory.cardFactory = CardMaker()
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewFactory = viewFactory
        controller.coordinator = coordinator as? ListUsersCoordinable
        controller.searchController = searchBarController
        controller.searchHandlerEvents = viewModel
        controller.dataHandler = viewModel
        return controller
    }
}
