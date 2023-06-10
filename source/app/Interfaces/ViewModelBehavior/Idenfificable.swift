//
//  Idenfificable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 10/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Identificable where Self: Model {
    var identifier: Int? { get }
}
