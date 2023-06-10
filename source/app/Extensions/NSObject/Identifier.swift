//
//  Identifier.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol ClassName {}

extension ClassName where Self: NSObject {
    static var className: String {
        String(describing: self)
    }
}

extension NSObject: ClassName {}
