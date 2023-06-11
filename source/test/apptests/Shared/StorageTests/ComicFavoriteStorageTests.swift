//
//  ComicFavoriteStorageTests.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
import RealmSwift

final class ComicFavoriteStorageTests: RealmTestBase {

    var comicFavoriteStorage: StorerDelegate?
    
    override var name: String {
        ComicFavoriteStorageTests.className
    }
    
    override func setUp() {
        super.setUp()
        
        RealmInstance.main.realm = try? Realm()
        
        comicFavoriteStorage = ComicFavoriteStorage()
        
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
        
        guard var manyItem = manyItem else {
            XCTFail("manyItem not defined")
            return
        }
    
        try! RealmInstance.main.realm?.write {
            manyItem = manyItem.compactMap { $0.isFavorable = true; return $0 }
        }
        
        try! RealmInstance.main.realm?.write {
            RealmInstance.main.realm?.add(manyItem)
        }
        
        guard let items = comicFavoriteStorage?.listItems(from: Comic.self) else {
            XCTFail("Expect items")
            return
        }
        
        XCTAssertEqual(items.count, 20, "Expect 20 items")
        XCTAssertEqual(items.first?.identifier, manyItem.first?.identifier, "Expect 20 items")
    }
    
    func testComicAddFavorite() {
     
        comicFavoriteStorage?.save(item: oneItem, into: Comic.self) //save(comic: oneItem)

        guard let item = RealmInstance.main.realm?.objects(Comic.self).first else {
            XCTFail("At least one is expected.")
            return
        }

        XCTAssertTrue(item.isFavorable, "Expect take a item from local storage with property isFavorable with value `true`")
    }
    
    func testComicRemoveFavorite() {
        guard let oneItem = oneItem else {
            XCTFail("One item mock not found.")
            return
        }

        // Add mock value
        let realm = try! Realm()
        try! realm.write {
            oneItem.isFavorable = true
            realm.add(oneItem)
        }
        
        
        // Check if target item exist
        let savedItems = realm.objects(Comic.self)
        guard let item = savedItems.first else {
            XCTFail("At least one is expected.")
            return
        }
        
        // Start test
        comicFavoriteStorage?.remove(item: item, from: Comic.self) //remove(comic: oneItem, from: Comic.self)
        let removedItem = realm.objects(Comic.self).filter({ $0.isFavorable == true}).first
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
            oneItem.isFavorable = true
            realm.add(oneItem)
        }

        XCTAssertFalse(itemFromAPI.isFavorable)

        comicFavoriteStorage?.markItemFromApi(item: itemFromAPI, from: Comic.self)
        XCTAssertTrue(itemFromAPI.isFavorable)
    }
}
