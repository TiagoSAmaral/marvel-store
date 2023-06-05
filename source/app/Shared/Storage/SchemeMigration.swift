//
//  SchemeMigration.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmMigrationHandler {

    static func setMigrationVersion() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        
        #if DEBUG
            debugPrint("User Realm User file location: \(RealmInstance.main.realm?.configuration.fileURL?.path ?? "")")
        #endif
    }
}
