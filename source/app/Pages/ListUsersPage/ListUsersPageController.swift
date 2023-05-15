//
//  Controller.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListUserController where Self: UIViewController {
//    var viewModel: ListUserVM? { get }
//    var coordinator: ListUsersCoordinable? { get set }
    func updateView()
}

class ListUserPageController: UIViewController, ListUserController, Controller {

    var viewModel: ViewModelHandlerEventsControllerDelegate?
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactory?
    var coordinator: ListUsersCoordinable?
    var searchController: UISearchController?
    var searchHandlerEvents: UISearchBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showSearchField()
        viewFactory?.defineViewInController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    func updateView() {
        viewFactory?.reloadView()
    }
    
    func showSearchField() {
        guard let searchController = searchController else {
            return
        }
        navigationController?.view.backgroundColor = .white
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = searchHandlerEvents
    }
}
