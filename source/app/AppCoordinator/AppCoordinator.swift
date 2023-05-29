//
//  AppCoordinator.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController?
    var rootViewControler: UIViewController?
    
    required init(navigation: UINavigationController?) {
        self.navigationController = navigation
    }
    
    func start(with data: Model?) {
        
        let coordinatorChild = ListUsersPageCoordinator(navigation: navigationController)
        coordinatorChild.parentCoordinator = self
        childCoordinators?.append(coordinatorChild)
        coordinatorChild.start(with: nil)
    }
}
