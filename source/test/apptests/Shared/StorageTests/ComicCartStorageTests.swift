//
//  ComicCartStorage.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
import RealmSwift

final class ComicCartStorageTests: RealmTestBase {

    var localStorageCart: StorerDelegate?
    
    override var name: String {
        ComicCartStorageTests.className
    }
    
    override func setUp() {
        super.setUp()
        
        RealmInstance.main.realm = try? Realm()
        
        localStorageCart = ComicCartStorage()
        
        try! RealmInstance.main.realm?.write {
            RealmInstance.main.realm?.deleteAll()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        try! RealmInstance.main.realm?.write {
            RealmInstance.main.realm?.deleteAll()
        }
    }
    
    func testListComics() {
        let realm = try! Realm()
        try! realm.write {
            guard var manyItem = manyItem else {
                XCTFail("manyItem not defined")
                return
            }
            manyItem = manyItem.compactMap { $0.isIntoCart = true; return $0 }
            realm.add(manyItem)
        }
        
        guard let items = localStorageCart?.listItems(from: Comic.self) else {
            XCTFail("Expect items")
            return
        }
        
        XCTAssertEqual(items.count, 20, "Expect 20 items")
        XCTAssertEqual(items.first?.identifier, manyItem?.first?.identifier, "Expect 20 items")
    }
    
    func testComicAddFavorite() {

        localStorageCart?.save(item: oneItem, into: Comic.self)
        
        let realm = try! Realm()
        
        guard let item = realm.objects(Comic.self).first else {
            XCTFail("At least one is expected.")
            return
        }
        
        XCTAssertTrue(item.isIntoCart, "Expect take a item from local storage with property isIntoCart with value `true`")
    }
    
    func testComicRemoveFavorite() {
        guard let oneItem = oneItem else {
            XCTFail("One item mock not found.")
            return
        }
        
        // Add mock value
        let realm = try! Realm()
        try! realm.write {
            oneItem.isIntoCart = true
            realm.add(oneItem)
        }
        
        // Check if target item exist
        let savedItems = realm.objects(Comic.self)
        guard let item = savedItems.first else {
            XCTFail("At least one is expected.")
            return
        }
        
        // Start test
        localStorageCart?.remove(item: item, from: Comic.self)
        let removedItem = realm.objects(Comic.self).filter({ $0.isIntoCart == true}).first
        XCTAssertEqual(removedItem, nil, "Expect nil")
    }

    func testCheckIfItemIsFavorite() {
        guard let oneItem = oneItem else {
            XCTFail("One item mock not found.")
            return
        }
        let itemFromAPI = Comic()
        itemFromAPI.identifier = oneItem.identifier
        // Add mock value
        let realm = try! Realm()
        try! realm.write {
            oneItem.isIntoCart = true
            realm.add(oneItem)
        }
    
        XCTAssertFalse(itemFromAPI.isIntoCart)
        
        localStorageCart?.markItemFromApi(item: itemFromAPI, from: Comic.self)
        XCTAssertTrue(itemFromAPI.isIntoCart)
    }
}
