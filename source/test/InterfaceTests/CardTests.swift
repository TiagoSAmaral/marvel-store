//
//  CardTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 31/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
@testable import Marvel_Store_Dev

class CardViewTest: UIView, Card {
    var exposedContent: Marvel_Store_Dev.Model?
    func load(model: Marvel_Store_Dev.Model?) {
        exposedContent = model
    }
}

struct TestModel: Model {
    var identifier: Int?
    
    var layout: LayoutView?
    
    var action: ((Model?) -> Void)?
}

final class CardTests: XCTestCase {
    
    let valueIdentifierTest: Int = 125125125
    let valueLayoutTest: LayoutView = .cartlist

    var cardTest: CardViewTest?
    var modelTest: TestModel?
    
    override func setUp() {
        cardTest = CardViewTest()
        modelTest = TestModel()
        
        modelTest?.identifier = 125125125
        modelTest?.layout = .cartlist
    }
    
    func testLoadModel() throws {
        cardTest?.load(model: modelTest)
        
        XCTAssertEqual(cardTest?.exposedContent?.identifier, valueIdentifierTest, "Expect keep same value of identifier")
        XCTAssertEqual(cardTest?.exposedContent?.layout, valueLayoutTest, "Expect keep same value of layout identifier")
    }
    
    func testDefineLayout() throws {
        let subview = UIView()
        
        XCTAssertEqual(cardTest?.subviews.count, 0, "Expected zero subview before define layout")
        cardTest?.defineLayout(with: subview)
        XCTAssertGreaterThan(subview.subviews.count, 0, "Expected quantity above zero.")
    }
}
