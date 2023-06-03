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

        let controller = DetailContentPageController()
        let viewModel = DetailContentPageViewModel(controller: controller)
//        let viewFactory = ListFactoryView(controller: controller)
        let network = NetworkRequestContent()
        
        viewModel.userDetailNetwork = network
        viewModel.valueToRequest = model as? ViewModelBehavior
        viewModel.coordinator = coordinator as? DetailContentCoordinable
//        viewFactory.cardFactory = CardMaker()
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
//        controller.viewFactory = viewFactory
        controller.coordinator = coordinator as? DetailContentCoordinable
//        controller.dataHandler = viewModel
        return controller
    }
}
