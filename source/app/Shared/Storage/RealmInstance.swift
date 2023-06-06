//
//  RealmInstance.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

class RealmInstance {    
    static let main = RealmInstance()
    let realm = try? Realm()
    
    static func sanitizeRealm() {
        let items = main.realm?.objects(Comic.self)
        try? main.realm?.write {
            if let itemsToRemove = items?.where({ $0.isFavorable == false && $0.isIntoCart == false }) {
                main.realm?.delete(itemsToRemove)
            }
        }
    }
}
