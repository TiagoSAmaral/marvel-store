//
//  TypePrice.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import RealmSwift

enum TypePrice: String, Codable, PersistableEnum {
    case printPrice, digitalPurchasePrice
}
