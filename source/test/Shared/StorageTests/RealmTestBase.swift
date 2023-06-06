//
//  RealmTestBase.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
import Realm
import RealmSwift
@testable import Marvel_Store_Dev

class RealmTestBase: XCTestCase {

    var oneItem: Comic?
    var manyItem: [Comic]?
    
    override func setUp() {
        super.setUp()
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        
        loadOneItem()
        loadManyItem()
    }
    private func loadOneItem() {
        let contentProvider =  MockerContentProvider()
        
        oneItem = contentProvider.loadOneItem(type: Comic.self)
    }
    
    private func loadManyItem() {
        let contentProvider =  MockerContentProvider()
        manyItem = contentProvider.loadManyItem(type: Comic.self)
    }
}
