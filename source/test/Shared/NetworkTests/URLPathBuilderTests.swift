//
//  URLPathBuilderTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 02/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
@testable import Marvel_Store_Dev

final class URLPathBuilderTests: XCTestCase {
    
    var urlPathBuilder: URLPathBuilder?
    
    let SEARCH_PARAM_TEST = "iron man"
    let START_YEAR_PARAM_TEST = "2022"
    let OFFSET_PARAM_TEST = 21
    let IDENTIFIER_PARAM_TEST = 19856
    
    let SEARCH_BY_TITLE_URI_PARAM_TEST = "title"
    let START_YEAR_URI_PARAM_TEST = "startYear"
    let OFFSET_URI_PARAM_TEST = "offset"
    
    let EXPECTED_SEARCH_PARAM_TEST = "iron%20man"
    
    override func setUp() {
        urlPathBuilder = URLPathBuilder(apiSecurer: APISecurity())
    }
    
    func testListItemsWithPaginatePath() {
        guard let urlPath = urlPathBuilder?.makeUrlWith(identifier: nil, search: nil, filterSince: nil, startFrom: OFFSET_PARAM_TEST) else {
            XCTFail("Not create urlPath")
            return
        }
        
        XCTAssertTrue(urlPath.absoluteString.contains("\(OFFSET_URI_PARAM_TEST)=\(OFFSET_PARAM_TEST)"), "Expect that contains uri fragment of offset pagination.")
    }
    
    func testFilterItemsWithYearPath() {
        guard let urlPath = urlPathBuilder?.makeUrlWith(identifier: nil, search: nil, filterSince: START_YEAR_PARAM_TEST, startFrom: OFFSET_PARAM_TEST) else {
            XCTFail("Not create urlPath")
            return
        }
        
        XCTAssertTrue(urlPath.absoluteString.contains("\(START_YEAR_URI_PARAM_TEST)=\(START_YEAR_PARAM_TEST)"), "Expect that contains uri fragment of year with pagination.")
    }
    
    func testGetSearchRouterPath() {
        guard let urlPath = urlPathBuilder?.makeUrlWith(identifier: nil, search: SEARCH_PARAM_TEST, filterSince: nil, startFrom: OFFSET_PARAM_TEST) else {
            XCTFail("Not create urlPath")
            return
        }
        
        XCTAssertTrue(urlPath.absoluteString.contains("\(OFFSET_URI_PARAM_TEST)=\(OFFSET_PARAM_TEST)"), "Expect that contains uri fragment of offset pagination.")
        
        XCTAssertTrue(urlPath.absoluteString.contains("\(SEARCH_BY_TITLE_URI_PARAM_TEST)=\(EXPECTED_SEARCH_PARAM_TEST)"), "Expect that contains uri fragment of search title.")
    }
    
    func testGetDetailRouterPath() {
        guard let urlPath = urlPathBuilder?.makeUrlWith(identifier: IDENTIFIER_PARAM_TEST, search: nil, filterSince: nil, startFrom: OFFSET_PARAM_TEST) else {
            XCTFail("Not create urlPath")
            return
        }
        XCTAssertTrue(urlPath.absoluteString.contains("\(OFFSET_URI_PARAM_TEST)=\(OFFSET_PARAM_TEST)"), "Expect that contains uri fragment of offset pagination.")
        XCTAssertTrue(urlPath.absoluteString.contains("/\(IDENTIFIER_PARAM_TEST)"), "Expect that contains Identifier of item")
    }
}
