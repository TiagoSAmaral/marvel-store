//
//  AlertViewFActory.swift
//  list-storeTests
//
//  Created by Tiago Amaral on 07/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class AlertViewFactoryTests: XCTestCase {

    let valueTitleVerification: String = "alert_test_title_value"
    let valueMessageVerification: String = "alert_test_message_value"

    func testMakeAlertViewController() {
        
        let alertController = AlertViewFactory.makeAlert(with: valueTitleVerification,
                                                         and: valueMessageVerification,
                                                         handler: nil)
        
        XCTAssertTrue(type(of: alertController) == UIAlertController.self, "Expect instance of class UIAlertController")
        XCTAssertEqual(alertController.title, valueTitleVerification, "Expect same title")
        XCTAssertEqual(alertController.message, valueMessageVerification, "Expect same message")

    }
}
