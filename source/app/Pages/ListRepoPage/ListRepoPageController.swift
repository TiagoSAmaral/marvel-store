//
//  Controller.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListReposController where Self: UIViewController {
    func updateView()
}

class ListReposPageController: UIViewController, ListReposController, Controller {

    var viewModel: ViewModelHandlerEventsControllerDelegate?
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactory?
    var coordinator: ListReposCoordinable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
       
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewFactory?.defineViewInController()
        viewModel?.viewDidAppear()
    }
    
    func updateView() {
        viewFactory?.reloadView()
    }
}
