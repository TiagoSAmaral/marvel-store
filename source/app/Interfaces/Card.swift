//
//  CardAction.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol Card where Self: UIView {
    func load(model: Model?)
}

extension Card {
    func defineLayout(with view: UIView?) {
        
        guard let view = view else {
            return
        }
        view.addSubview(self)
        
        edgeToSuperView()
    }
}
