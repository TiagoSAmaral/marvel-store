//
//  PageFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class UserDetailPageFactory: FactoryPage {
    
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {

        let controller = UserDetailPageController()
        let viewModel = UserDetailPageViewModel(controller: controller)
        let viewFactory = ListFactoryView(controller: controller)
//        let headerFactory = NetworkHeaderMaker()
        let network = NetworkUserInfo(headerFactory: nil)
        
        viewModel.userDetailNetwork = network
        viewModel.valueToRequest = model
        viewModel.coordinator = coordinator as? UserDetailCoordinable
        viewFactory.cardFactory = CardMaker()
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewFactory = viewFactory
        controller.coordinator = coordinator as? UserDetailCoordinable
        controller.dataHandler = viewModel
        return controller
    }
}
