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
}
