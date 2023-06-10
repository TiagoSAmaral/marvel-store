//
//  RealmInstanceTests.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

import XCTest
import RealmSwift

final class RealmInstaceTests: RealmTestBase {
    
    override var name: String {
        RealmInstaceTests.className
    }
    
    override func setUp() {
        super.setUp()
        
        RealmInstance.main.realm = try? Realm()
        
        try! RealmInstance.main.realm?.write {
            RealmInstance.main.realm?.deleteAll()
        }
        
        guard let oneItem = oneItem else {
            XCTFail("Expect a oneItem")
            return
        }
        
        try! RealmInstance.main.realm?.write {
            oneItem.isFavorable = true
            oneItem.isIntoCart = true
            RealmInstance.main.realm?.add(oneItem)
        }
    }
    
    func testFailRemoveWhenComicIsFavoritedAndIntoCart() {

        RealmInstance.sanitizeRealm()
        
        let item = RealmInstance.main.realm?.objects(Comic.self).first
        
        try! RealmInstance.main.realm?.write {
            item?.isFavorable = true
            item?.isIntoCart = true
        }
        
        RealmInstance.sanitizeRealm()
        
        let targetTest = RealmInstance.main.realm?.objects(Comic.self).first
        XCTAssertNotNil(targetTest, "Expect found one item")
    }
    
    func testeFailRemoveWhenComicIsIntoCart() {
        let item = RealmInstance.main.realm?.objects(Comic.self).first
        
        try! RealmInstance.main.realm?.write {
            item?.isFavorable = false
            item?.isIntoCart = true
        }
        
        RealmInstance.sanitizeRealm()
        
        let targetTest = RealmInstance.main.realm?.objects(Comic.self).first
        XCTAssertNotNil(targetTest, "Expect found one item")
    }
    
    func testFailRemoveWhenComicIsFavorited() {
        let item = RealmInstance.main.realm?.objects(Comic.self).first
        
        try! RealmInstance.main.realm?.write {
            item?.isFavorable = true
            item?.isIntoCart = false
        }
        
        RealmInstance.sanitizeRealm()
        
        let targetTest = RealmInstance.main.realm?.objects(Comic.self).first
        XCTAssertNotNil(targetTest, "Expect found one item")
    }
    
    func testSuccessInRemove() {
        let item = RealmInstance.main.realm?.objects(Comic.self).first
        
        try! RealmInstance.main.realm?.write {
            item?.isFavorable = false
            item?.isIntoCart = false
        }
        
        RealmInstance.sanitizeRealm()
        
        let targetTest = RealmInstance.main.realm?.objects(Comic.self).first
        XCTAssertNil(targetTest, "Expect found nil")
    }
}
