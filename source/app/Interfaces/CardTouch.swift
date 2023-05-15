//
//  CardTouch.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol CardTouch where Self: UIView {
    var action: ((Model?) -> Void)? { get set }
    func defineAction()
}

extension CardTouch {
    func defineAction() {}
}
