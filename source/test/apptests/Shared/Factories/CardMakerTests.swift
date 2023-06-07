//
//  CardMakerTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 07/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class CardMakerTests: XCTestCase {
    
    var cardMaker: CardFactory?
    
    override func setUp() {
        cardMaker = CardMaker()
    }
    
    func testMakeListContentLayoutCard() {
        
        var model: ViewModelBehavior = TestModel(isFavorable: false, isIntoCart: false)
        model.layout = .listContentLayoutCard
        guard let card = cardMaker?.makeCard(from: model) as? Card else {
            XCTFail("Expect one valid instance")
            return
        }
        let isCardProtocolConformance = card is Card
        XCTAssertTrue(isCardProtocolConformance, "Expect a view of type Card interface")
    }
    
    func testMakeDetailContentLayoutCard() {
        var model: ViewModelBehavior = TestModel(isFavorable: false, isIntoCart: false)
        model.layout = .detailContentLayoutCard
        guard let card = cardMaker?.makeCard(from: model) as? Card else {
            XCTFail("Expect one valid instance")
            return
        }
        let isCardProtocolConformance = card is Card
        XCTAssertTrue(isCardProtocolConformance, "Expect a view of type Card interface")
    }
    
    func testModelWithLayioutViewValueNil() {
        var model: ViewModelBehavior = TestModel(isFavorable: false, isIntoCart: false)
        let card = cardMaker?.makeCard(from: model) as? Card
        XCTAssertNil(card, "Expect a nil value")
    }
    
    func testReceiveNilItem() {
        let card = cardMaker?.makeCard(from: nil) as? Card
        XCTAssertNil(card, "Expect a nil value")
    }
}
