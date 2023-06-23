//
//  Coordinator.swift
//  list-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListContentCoordinable where Self: Coordinator {
    func goToContentDetail(with data: Model?)
}

class ListContentPageCoordinator: Coordinator, ListContentCoordinable {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]?
    weak var navigationController: UINavigationController?
    weak var rootViewControler: UIViewController?
    
    required init(navigation: UINavigationController?) {
        navigationController = navigation
    }
    
    func start(with data: Model?) {
        guard let controller = ListContentPageFactory.makePage(coordinator: self, model: nil) else {
            return
        }
        navigationController?.viewControllers = [controller]
    }
    
    func goToContentDetail(with data: Model?) {
        let userDetailCoordinator = DetailContentPageCoordinator(navigation: navigationController)
        userDetailCoordinator.parentCoordinator = self
        childCoordinators?.append(userDetailCoordinator)
        userDetailCoordinator.start(with: data)
    }
    
    func popToRootViewController() {
        guard let rooViewController = rootViewControler else {
            return
        }
        navigationController?.popToViewController(rooViewController, animated: true)
    }
    
    func didFinishChild(_ child: Coordinator?) {
        
        guard let childCoordinators = childCoordinators else {
            return
        }
        
        let shadowChildCoorinators = childCoordinators
        
        for (index, item) in shadowChildCoorinators.enumerated() where item === child {
            self.childCoordinators?.remove(at: index)
        }
        
        popToRootViewController()
    }
}
