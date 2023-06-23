//
//  Coordinator.swift
//  list-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol Coordinator where Self: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator]? { get set }
    var navigationController: UINavigationController? { get set }
    var rootViewControler: UIViewController? { get set }
   
    init(navigation: UINavigationController?)
    func start(with data: Model?)
    func popToRootViewController()
    func didFinishChild(_ child: Coordinator?)
}

extension Coordinator {
    func popToRootViewController() {}
    func didFinishChild(_ child: Coordinator?) {}
}
