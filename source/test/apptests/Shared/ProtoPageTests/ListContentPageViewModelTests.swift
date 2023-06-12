//
//  ViewModelTests.swift
//  marvel-storeTests
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListContentPageViewModelTests: XCTestCase {

    var out: ListContentPageViewModel?
    
    override func setUp() {
        out = FactoryToTest.build()
    }
    
    func testFilterYearDisableFilterValue() {
        XCTAssertEqual(out?.disableFilterOptions, "Todos", "Expect be equal.")
    }
    
    func testListOfYears() {
        guard let listYearFilter = out?.listYearFilter else {
            XCTFail("Spect not nil")
            return
        }
        
        let currentYear: String = "\(Calendar.current.component(.year, from: Date()))"
        
        XCTAssertEqual(listYearFilter.first, "Todos", "Expect `Todos` value")
        XCTAssertEqual(listYearFilter[1], currentYear, "Expect current year at position 1")
        XCTAssertEqual(listYearFilter.last, "1938", "Expect 1938 value at last position")
    }
    
    func testLoadDetailOfOneItem() {
        
        let oneItem = MockerContentProvider().loadOneItem(type: Comic.self)
        out?.selectedItem = oneItem
        out?.loadDetailOfItem()
        
        guard let networkFake = out?.network as? NetworkContentOperationFake, let
        requestParamIntercepted = networkFake.paramRequestIntercepted else {
            XCTFail("Expect NetworkContentOperationFake instance")
            return
        }
        XCTAssertEqual(out?.currentPage, .zero, "Expected page zero")
        XCTAssertEqual(requestParamIntercepted.layoutView, .detailContentLayoutCard, "Expected `.detailContentLayoutCard` value.")
        XCTAssertEqual(requestParamIntercepted.identifier, oneItem?.identifier, "Expected same identifier of selectedItem into RequestParam.")
    }
    
    func testLoadStoreItems() {
        out?.currentPage = 3
        out?.currentSearchValue = "Avengers"
        out?.selectedFilterOption = "2006"
        
        out?.loadStoreItems()
        
        guard let networkFake = out?.network as? NetworkContentOperationFake, let
        requestParamIntercepted = networkFake.paramRequestIntercepted else {
            XCTFail("Expect NetworkContentOperationFake instance")
            return
        }
        
        XCTAssertEqual(out?.currentPage, .zero, "Expected page zero")
        XCTAssertEqual(out?.currentSearchValue, nil, "Expect to be nil")
        XCTAssertEqual(out?.selectedFilterOption, nil, "Expect to be nil")
        XCTAssertEqual(requestParamIntercepted.sincePage, .zero, "Expected param page zero")
        XCTAssertEqual(requestParamIntercepted.layoutView, .listContentLayoutCard, "Expected param layout item `.listContentLayoutCard` value")
    }
    
    func testSaveItemToFavorite() {
        out?.currentViewModelStrategy = .detail
    }
}
