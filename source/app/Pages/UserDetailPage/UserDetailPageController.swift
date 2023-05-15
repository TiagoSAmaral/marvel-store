//
//  Controller.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol UserDetailController where Self: UIViewController {
    func updateView()
}

class UserDetailPageController: UIViewController, UserDetailController, Controller {
        
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactoryView?
    var viewModel: ViewModelHandlerEventsControllerDelegate?
    var coordinator: UserDetailCoordinable?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear()
        viewFactory?.defineViewInController()
    }
    
    func updateView() {
        viewFactory?.reloadView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.didFinishChild()
    }
}
