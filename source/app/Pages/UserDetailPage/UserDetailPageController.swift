//
//  Controller.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol UserDetailController where Self: UIViewController {
    func updateView()
    func startLoading()
    func stopLoading(onFinish: (() -> Void)?)
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?)
}

class UserDetailPageController: UIViewController, UserDetailController, Controller, LoadingManagers, AlertPresetable {
    var loadingController: LoadingViewController?
    var dataHandler: ListDataHandler?
    var viewFactory: ListFactoryView?
    var viewModel: ViewModelHandlerEventsControllerDelegate?
    var coordinator: UserDetailCoordinable?

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.didFinishChild()
    }
}
