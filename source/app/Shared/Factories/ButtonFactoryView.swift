//
//  Defaultbutton.swift
//  list-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct FactoryButton {
    static func makeDeafaultButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(ColorAsset.titleColor, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = ColorAsset.borderColor?.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 6.0
        return button
    }
}
