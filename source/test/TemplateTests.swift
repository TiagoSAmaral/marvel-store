//
//  TemplateTests.swift
//  BaseProjectTargetTests
//
//  Created by Tiago Amaral on 31/01/20.
//  Copyright © 2020 Tiago Amaral. All rights reserved.
//

import XCTest
@testable import BaseProjectTarget

class TemplateTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testCheckReadmeMessage() {
        let expectedString = "Verifique o arquivo Readme! \n Português Brasil"
        XCTAssert(LocalizedText.with(tagName: .messageReadme) == expectedString, "Expect equals")
    }
}
