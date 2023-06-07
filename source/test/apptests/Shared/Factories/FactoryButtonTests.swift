//
//  FactoryButtonTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 07/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class FactoryButtonTests: XCTestCase {

    let TITLE_BUTTON_CHECK = "title_button"
    let BORDER_WITH_CHECK = 1.0
    let CORNER_WITH_CHECK =  6.0
    
    func testMakeButton() {
        
        let button = FactoryButton.makeDeafaultButton(with: TITLE_BUTTON_CHECK)
        
        XCTAssertEqual(button.titleLabel?.text, TITLE_BUTTON_CHECK, "Expect same title")
        XCTAssertEqual(button.layer.borderWidth, BORDER_WITH_CHECK, "Expect same border width")
        XCTAssertEqual(button.layer.cornerRadius, CORNER_WITH_CHECK, "Expect same corner radius")
    }
}
