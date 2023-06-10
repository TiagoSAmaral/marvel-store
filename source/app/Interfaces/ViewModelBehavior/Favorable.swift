//
//  Favoritable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol Favorable where Self: Model {
    var isFavorable: Bool { get set }
    var addFavoriteAction: ((Model?) -> Void)? { get set }
    var removeFavoriteAction: ((Model?) -> Void)? { get set }
}
