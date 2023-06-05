//
//  LayoutView.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

enum LayoutView: String, Codable, PersistableEnum {
    case listContentLayoutCard
    case detailContentLayoutCard
    case favoritContentLayoutCard
    case cartContentLayoutCard
}
