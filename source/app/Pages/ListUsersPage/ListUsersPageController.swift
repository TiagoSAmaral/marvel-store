//
//  Controller.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListUserController where Self: UIViewController {
    func updateView()
    func startLoading()
    func stopLoading(onFinish: (() -> Void)?)
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)? )
}

class ListUserPageController: UIViewController, ListUserController, Controller, LoadingManagers, AlertPresetable {

    var viewModel: ViewModelHandlerEventsControllerDelegate?
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactory?
    var coordinator: ListUsersCoordinable?
    var searchController: UISearchController?
    var searchHandlerEvents: UISearchBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFactory?.defineViewInController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSearchField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController?.isActive = false
    }
    
    func updateView() {
        viewFactory?.reloadView()
    }
    
    func showSearchField() {
        guard let searchController = searchController, navigationItem.titleView == nil else {
            return
        }
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = searchHandlerEvents
    }
}
