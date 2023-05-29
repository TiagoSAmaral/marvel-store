//
//  identifier.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Model {
    var identifier: Int? { get }
//  Allow seter becouse not exist in API and, need adapter into CardFactory
    var layout: LayoutView? { get set}
    var action: ((Model?) -> Void)? { get set}
}
