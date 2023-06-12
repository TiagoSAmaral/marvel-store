//
//  ListContentCoordinatorFake.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

final class ListContentPageCoordinatorFake: ListContentCoordinable {
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator]?
    
    var navigationController: UINavigationController?
    
    var rootViewControler: UIViewController?
    
    init(navigation: UINavigationController?) {
    }
    
    func start(with data: Model?) {
    }
    
    // MARK: - ListContentCoordinable
    func goToContentDetail(with data: Model?) {
    }
}
