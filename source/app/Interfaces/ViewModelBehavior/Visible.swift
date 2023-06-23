//
//  Visible.swift
//  list-store
//
//  Created by Tiago Amaral on 10/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Visible where Self: Model {
    var layout: LayoutView? { get set}
}
