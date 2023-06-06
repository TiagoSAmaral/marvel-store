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
    var exposedContent: Model?
    func load(model: Model?) {
        exposedContent = model
    }
}

struct TestModel: Model, ViewModelBehavior {
    var isIntoCart: Bool
    
    var addCartAction: ((Marvel_Store_Dev.Model?) -> Void)?
    
    var removeCartAction: ((Marvel_Store_Dev.Model?) -> Void)?
    
    var isFavorable: Bool
    
    var addFavoriteAction: ((Marvel_Store_Dev.Model?) -> Void)?
    
    var removeFavoriteAction: ((Marvel_Store_Dev.Model?) -> Void)?
    
    var selectAction: ((Marvel_Store_Dev.Model?) -> Void)?
    
    var identifier: Int?
    
    var layout: LayoutView?
    
    var action: ((Model?) -> Void)?
}

final class CardTests: XCTestCase {
    
    let valueIdentifierTest: Int = 125125125
    let valueLayoutTest: LayoutView = .listContentLayoutCard

    var cardTest: CardViewTest?
    var modelTest: TestModel?
    
    override func setUp() {
        cardTest = CardViewTest()
        modelTest = TestModel(isIntoCart: false, isFavorable: false)
        
        modelTest?.identifier = 125125125
        modelTest?.layout = .listContentLayoutCard
    }
    
    func testLoadModel() throws {
        cardTest?.load(model: modelTest)
        let exposed = cardTest?.exposedContent as? ViewModelBehavior
        XCTAssertEqual(exposed?.identifier, valueIdentifierTest, "Expect keep same value of identifier")
        XCTAssertEqual(exposed?.layout, valueLayoutTest, "Expect keep same value of layout identifier")
    }
    
    func testDefineLayout() throws {
        let subview = UIView()
        
        XCTAssertEqual(cardTest?.subviews.count, 0, "Expected zero subview before define layout")
        cardTest?.defineLayout(with: subview)
        XCTAssertGreaterThan(subview.subviews.count, 0, "Expected quantity above zero.")
    }
}
