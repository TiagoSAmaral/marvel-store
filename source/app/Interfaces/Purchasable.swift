//
//  Purchasable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Purchasable {
    var isPurchasable: Bool { get set }
    var purchaseAction: ((Model?) -> Void)? { get set }
}
