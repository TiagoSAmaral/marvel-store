//
//  CurrencyConversorTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 07/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class CurrencyConversorTests: XCTestCase {

    let DOUBLE_VALUE_CHECK: Double = 153.88
    let STRING_VALUE_CHECK: String = "R$ 153,88"
    
    func testFromatCurrency() {
            
        guard var finalStringValue = CurrencyConversor.formatFrom(value: DOUBLE_VALUE_CHECK) else {
            XCTFail("Expect valid value")
            return
        }
        finalStringValue = finalStringValue.replacingOccurrences(of: "\u{A0}", with: " ")
        let isEqualValue = finalStringValue == STRING_VALUE_CHECK
        XCTAssertTrue(isEqualValue, "Expect value true")
    }
}
