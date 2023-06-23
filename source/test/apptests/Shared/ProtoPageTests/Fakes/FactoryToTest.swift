//
//  FactoryToTest.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum FactoryToTest {
    static func build(networkTypeResponse: ResponseSelector = .successList) -> ListContentPageViewModel {
        
        let viewModel = ListContentPageViewModel()
        let controller = ListContentPageControllerFake()
        
        controller.viewModel = viewModel
        viewModel.controller = controller
        viewModel.network = NetworkContentOperationFake(selectorResultType: networkTypeResponse)
        viewModel.coordinator = ListContentPageCoordinatorFake(navigation: NavigationController())
        viewModel.localStorageCartItems = LocalStorageFake()
        viewModel.localStorageFavoriteItems = LocalStorageFake()
        return viewModel
    }
}
