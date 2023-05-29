//
//  AlertPresentable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 16/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol AlertPresetable where Self: UIViewController {
    
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?)
}

extension AlertPresetable {
    func presentAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?) {
        present(AlertViewFactory.makeAlert(with: title, and: message, handler: handler), animated: true)
    }
}
