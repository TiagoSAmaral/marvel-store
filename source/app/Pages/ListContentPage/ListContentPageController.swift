//
//  Controller.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListContentController where Self: UIViewController {
    var viewDidAppearEvent: (() -> Void)? { get set }
    func updateView()
    func startLoading()
    func stopLoading(onFinish: (() -> Void)?)
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)? )
    func disableSearch()
}

class ListContentPageController: UIViewController, ListContentController, LoadingManagers, AlertPresetable {

    var viewModel: ViewModable?
    var coordinator: ListContentCoordinable?
    var searchController: UISearchController?
    var searchHandlerEvents: UISearchBarDelegate?
    var listView: ListUpdateEvent?
    var viewDidAppearEvent: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSearchField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearEvent?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController?.isActive = false
    }
    
    func updateView() {
        listView?.reloadView()
    }
    
    func showSearchField() {
        guard let searchController = searchController, navigationItem.titleView == nil else {
            return
        }
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = searchHandlerEvents
    }

    func disableSearch() {
        searchController?.isActive = false
    }
}
