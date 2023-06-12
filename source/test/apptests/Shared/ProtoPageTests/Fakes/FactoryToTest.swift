//
//  FactoryToTest.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum FactoryToTest {
    static func build() -> ListContentPageViewModel {
        
        let viewModel = ListContentPageViewModel()
        let controller = ListContentPageControllerFake()
        
        controller.viewModel = viewModel
        viewModel.controller = controller
        viewModel.network = NetworkContentOperationFake()
        viewModel.coordinator = ListContentPageCoordinatorFake(navigation: NavigationController())
        viewModel.localStorageCartItems = LocalStorageCartItemsFake()
        viewModel.localStorageFavoriteItems = LocalStorageFavoritesItemsFake()
        return viewModel
    }
}
