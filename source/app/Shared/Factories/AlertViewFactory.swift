//
//  Alertview.swift
//  marvel-store
//
//  Created by Tiago Amaral on 16/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct AlertViewFactory {
    
    static func makeAlert(with title: String?, and message: String?, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
     
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: LocalizedText.with(tagName: .close), style: .default, handler: handler))
        return controller
    }
}
