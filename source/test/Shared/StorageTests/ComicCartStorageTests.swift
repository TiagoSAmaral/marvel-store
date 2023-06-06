//
//  ComicCartStorage.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
import RealmSwift

@testable import Marvel_Store_Dev

final class ComicCartStorageTests: RealmTestBase {

    override var name: String {
        ComicCartStorageTests.identifier
    }
    
    override func setUp() {
        super.setUp()
        
        RealmInstance.main.realm = try? Realm()
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
            manyItem.compactMap { $0.isIntoCart = true }
            realm.add(manyItem)
        }
        
        let items = ComicCartStorage.main.listComics()
        
        XCTAssertEqual(items?.count, 20, "Expect 20 items")
        XCTAssertEqual(items?.first?.identifier, manyItem?.first?.identifier, "Expect 20 items")
    }
    
    func testComicAddFavorite() {
     
        ComicCartStorage.main.save(comic: oneItem)
        
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
        
        // Check if taget item exist
        guard let item = ComicCartStorage.main.listComics()?.first else {
            XCTFail("At least one is expected.")
            return
        }
        
        // Start test
        ComicCartStorage.main.remove(comic: item)
        
        let removedItem = realm.objects(Comic.self).filter({ $0.isIntoCart == true}).first
        
        XCTAssertEqual(removedItem, nil, "Expect nil")
    }
    
    func testGetUniqueComic() {
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
        
        let item = ComicCartStorage.main.get(comic: oneItem.identifier)
        
        XCTAssertEqual(item?.identifier, oneItem.identifier, "Expect get same item")
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
        
        ComicCartStorage.main.markItemFromApiLikeIntoCart(item: itemFromAPI)
        XCTAssertTrue(itemFromAPI.isIntoCart)
    }
}
