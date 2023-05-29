//
//  Coordinator.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit
import SafariServices

protocol ListReposCoordinable where Self: Coordinator {
    func goToRepo(with data: Model?)
    func didFinishChild()
    func back()
}

class ListReposPageCoordinator: Coordinator, ListReposCoordinable {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]?
    weak var navigationController: UINavigationController?
    weak var rootViewControler: UIViewController?
    
    required init(navigation: UINavigationController?) {
        navigationController = navigation
    }
    
    func start(with data: Model?) {
        guard let controller = ListReposPageFactory.makePage(coordinator: self, model: data) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToRepo(with data: Model?) {
        guard let data = data as? RepoListemItem,
              let urlHtml = data.htmlUrl,
                let urlpath = URL(string: urlHtml) else {
            return
        }
       
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariViewController = SFSafariViewController(url: urlpath, configuration: config)
        navigationController?.present(safariViewController, animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        guard let rooViewController = rootViewControler else {
            return
        }
        navigationController?.popToViewController(rooViewController, animated: true)
    }
    
    func didFinishChild() {
        parentCoordinator?.didFinishChild(self)
        parentCoordinator = nil
        rootViewControler = nil
    }
}
