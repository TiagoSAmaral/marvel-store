//
//  ComicPrice.swift
//  list-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import RealmSwift

class ComicPrice: Object, Codable {
    @Persisted var type: TypePrice?
    @Persisted var price: Double?
}
