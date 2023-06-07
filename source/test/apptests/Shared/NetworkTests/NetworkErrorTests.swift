//
//  NetworkErrorTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 02/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class NetworkErrorTests: XCTestCase {
    
    var networkErrorTarget: NetworkError?
    
    let OFFLINE_MESSAGE_TEST = LocalizedText.with(tagName: .networkOffline)
    let BADREQUEST_MESSAGE_TEST = LocalizedText.with(tagName: .networkErrorNotDefined)
    let SERVERNOTRESPONSE_MESSAGE_TEST = LocalizedText.with(tagName: .serverNotResponse)
    let NOTDEFINED_MESSAGE_TEST = LocalizedText.with(tagName: .networkErrorNotDefined)
    override func tearDown() {
        networkErrorTarget = nil
    }

    func testStatusOffline() {
        networkErrorTarget = NetworkError.makeError(with: -1)
        XCTAssertEqual(networkErrorTarget?.message, OFFLINE_MESSAGE_TEST, "Expect same message")
    }
    
    func testStatus400At499() {
        networkErrorTarget = NetworkError.makeError(with: 400)
        XCTAssertEqual(networkErrorTarget?.message, BADREQUEST_MESSAGE_TEST, "Expect same message")
    }
    
    func testStatusAbove499() {
        networkErrorTarget = NetworkError.makeError(with: 500)
        XCTAssertEqual(networkErrorTarget?.message, SERVERNOTRESPONSE_MESSAGE_TEST, "Expect same message")
    }
    
    func testStatusNotDefined() {
        networkErrorTarget = NetworkError.makeError(with: nil)
        XCTAssertEqual(networkErrorTarget?.message, NOTDEFINED_MESSAGE_TEST, "Expect same message")
    }
}
