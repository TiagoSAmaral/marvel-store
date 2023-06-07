//
//  APISecurityTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class APISecurityTests: XCTestCase {
    
    // To make this teste, is necessary to create a dev-info.plist with the hash generated, with the MOCK_MD5_TESTS key.
    // To generate this teste md5 value, use the instantiate a TimeInterval with 1.0 (double) value, your
    
//    MOCK_MD5_TESTS
    var apiSecurer: APISecurer?
    override func setUp() async throws {
        apiSecurer = APISecurity(keyadvisor: MockerContentProvider())
    }
    
    func testGenerateSecuryURI() {
        
        let customTimeStamp = TimeInterval(1.0)
        guard let generatedApiSecInfo = apiSecurer?.makeCredential(with: customTimeStamp) else {
            XCTFail("Not generate API security info")
            return
        }
        XCTAssertEqual(MockerContentProvider().mockMD25Tests, generatedApiSecInfo.hash, "Expected equal hash")
        XCTAssertEqual(customTimeStamp, generatedApiSecInfo.timeStamp, "Expected equal timestamp")
    }
}
