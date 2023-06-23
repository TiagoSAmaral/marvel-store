//
//  ListContentPageControllerFake.swift
//  list-storeTests
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

final class ListContentPageControllerFake: UIViewController, ViewController {
    
    var viewModel: ViewModable?
    
    var viewDidAppearEvent: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
    }
    
    func startLoading() {
    }
    
    func stopLoading(onFinish: (() -> Void)?) {
    }
    
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?) {
    }
    
    func disableSearch() {
    }
}
