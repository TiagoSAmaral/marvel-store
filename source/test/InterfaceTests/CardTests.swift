//
//  CardTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 31/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

class CardViewTest: UIView, Card {
    var exposedContent: Model?
    func load(model: Model?) {
        exposedContent = model
    }
}

struct TestModel: Model, ViewModelBehavior {
    
    var addCartAction: ((Model?) -> Void)?
    
    var removeCartAction: ((Model?) -> Void)?
    
    var addFavoriteAction: ((Model?) -> Void)?
    
    var removeFavoriteAction: ((Model?) -> Void)?
    
    var selectAction: ((Model?) -> Void)?
    
    var isFavorable: Bool
    
    var isIntoCart: Bool
    
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
        modelTest = TestModel(isFavorable: false, isIntoCart: false)
        
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
