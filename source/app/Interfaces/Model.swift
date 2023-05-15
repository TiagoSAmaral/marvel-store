//
//  identifier.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Model {
    var identifier: Int? { get }
    var layout: LayoutView? { get }
    var action: ((Model?) -> Void)? { set get }
}
