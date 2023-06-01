//
//  TemplateTests.swift
//  BaseProjectTargetTests
//
//  Created on 31/01/20.
//

import XCTest
@testable import Marvel_Store_Dev

class TemplateTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testCheckReadmeMessage() {
        let expectedString = "Verifique o arquivo Readme! \n Português Brasil"
        XCTAssert(LocalizedText.with(tagName: .messageReadme) == expectedString, "Expect equals")
    }
}
