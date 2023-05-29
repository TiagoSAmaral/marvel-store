//
//  PageFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListReposPageFactory: FactoryPage {
    
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {

        let controller = ListReposPageController()
        let headerMaker = NetworkHeaderMaker()
        let network = NetworkUserInfo(headerFactory: headerMaker)
        let viewFactory = ListFactoryView(controller: controller)
        let viewModel = ListReposPageViewModel(controller: controller,
                                               network: network,
                                               coordinator: coordinator)
        viewModel.valueToRequest = model
        viewFactory.cardFactory = CardMaker()
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewFactory = viewFactory
        controller.coordinator = coordinator as? ListReposCoordinable
        controller.dataHandler = viewModel
        return controller
    }
}
