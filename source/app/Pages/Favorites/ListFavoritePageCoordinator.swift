//
//  ListFavoritePageCoordinator.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListFavoritePageCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator]?
    
    var navigationController: UINavigationController?
    
    var rootViewControler: UIViewController?
    
    required init(navigation: UINavigationController?) {
        self.navigationController = navigation
    }
    
    func start(with data: Model?) {
        guard let controller = ListFavoritePageFactory.makePage(coordinator: self, model: data) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
