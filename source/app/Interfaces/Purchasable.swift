//
//  Purchasable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Purchasable {
    var isIntoCart: Bool { get set }
    var addCartAction: ((Model?) -> Void)? { get set }
    var removeCartAction: ((Model?) -> Void)? { get set }
}
