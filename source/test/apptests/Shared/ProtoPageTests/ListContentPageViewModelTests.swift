//
//  ViewModelTests.swift
//  list-storeTests
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest

final class ListContentPageViewModelTests: XCTestCase {
    
    var out: ListContentPageViewModel = FactoryToTest.build()
    
    override func setUp() {
        out = FactoryToTest.build()
    }
    
    func testFilterYearDisableFilterValue() {
//        var out: ListContentPageViewModel = FactoryToTest.build()
        XCTAssertEqual(out.disableFilterOptions, "Todos", "Expect be equal.")
    }
    
    func testListOfYears() {
//        var out: ListContentPageViewModel = FactoryToTest.build()
        guard let listYearFilter = out.listYearFilter else {
            XCTFail("Spect not nil")
            return
        }
        
        let currentYear: String = "\(Calendar.current.component(.year, from: Date()))"
        
        XCTAssertEqual(listYearFilter.first, "Todos", "Expect `Todos` value")
        XCTAssertEqual(listYearFilter[1], currentYear, "Expect current year at position 1")
        XCTAssertEqual(listYearFilter.last, "1938", "Expect 1938 value at last position")
    }
    
    func testLoadDetailOfOneItem() {
//        var out: ListContentPageViewModel = FactoryToTest.build()
        let oneItem = MockerContentProvider().loadOneItem(type: Comic.self)
        out.selectedItem = oneItem
        out.loadDetailOfItem()
        
        guard let networkFake = out.network as? NetworkContentOperationFake, let
        requestParamIntercepted = networkFake.paramRequestIntercepted else {
            XCTFail("Expect NetworkContentOperationFake instance")
            return
        }
        XCTAssertEqual(out.currentPage, .zero, "Expected page zero")
        XCTAssertEqual(requestParamIntercepted.layoutView, .detailContentLayoutCard, "Expected `.detailContentLayoutCard` value.")
        XCTAssertEqual(requestParamIntercepted.identifier, oneItem?.identifier, "Expected same identifier of selectedItem into RequestParam.")
    }
    
    func testLoadStoreItems() {
//        var out: ListContentPageViewModel = FactoryToTest.build()
        out.currentPage = 3
        out.currentSearchValue = "Avengers"
        out.selectedFilterOption = "2006"
        
        out.loadStoreItems()
        
        guard let networkFake = out.network as? NetworkContentOperationFake, let
        requestParamIntercepted = networkFake.paramRequestIntercepted else {
            XCTFail("Expect NetworkContentOperationFake instance")
            return
        }
        
        XCTAssertEqual(out.currentPage, .zero, "Expected page zero")
        XCTAssertEqual(out.currentSearchValue, nil, "Expect to be nil")
        XCTAssertEqual(out.selectedFilterOption, nil, "Expect to be nil")
        XCTAssertEqual(requestParamIntercepted.sincePage, .zero, "Expected param page zero")
        XCTAssertEqual(requestParamIntercepted.layoutView, .listContentLayoutCard, "Expected param layout item `.listContentLayoutCard` value")
    }
    
    func testSaveItemToFavoriteOnDetailView() {
        let outInner: ListContentPageViewModel = FactoryToTest.build(networkTypeResponse: .successOne)
        let oneItem = MockerContentProvider().loadOneItem(type: Comic.self)
        let requestOne = MockerContentProvider().loadOneContent(type: GeneralResult<Comic>.self)
        outInner.currentViewModelStrategy = .detail
        outInner.selectedItem = oneItem
        
        // Load is necessary to (simulate) charge items with API content
        outInner.loadDetailOfItem()
        
        let expectRunRequest = expectation(description: "Expect run async request")
        
        DispatchQueue.main.async {
            expectRunRequest.fulfill()
            outInner.saveToFavorite(oneItem)
            
            guard let storageFavoriteFake = outInner.localStorageFavoriteItems as? LocalStorageFake else {
                XCTFail("Expected LocalStorageFake instance")
                return
            }
            
            guard let savedItem = storageFavoriteFake.savedItem else {
                XCTFail("Expected saveItem instance captured inside fake")
                return
            }
            
            guard let marketItem = storageFavoriteFake.markedItem else {
                XCTFail("Expected markedItem instance captured inside fake")
                return
            }
            
            XCTAssertEqual(savedItem.identifier, oneItem?.identifier, "Expect same identifier")
            XCTAssertEqual(outInner.items.count, 1, "Expect list of items nil")
            XCTAssertEqual(marketItem.identifier, (outInner.selectedItem as? ViewModelBehavior)?.identifier, "Expected same identifier of selected item" )
        }
       
        wait(for: [expectRunRequest])
    }
    
    func testRemoveItemFromFavoriteOnDetailView() {
        let outInner: ListContentPageViewModel = FactoryToTest.build(networkTypeResponse: .successOne)
        let oneItem = MockerContentProvider().loadOneItem(type: Comic.self)
        let requestOne = MockerContentProvider().loadOneContent(type: GeneralResult<Comic>.self)
        outInner.currentViewModelStrategy = .detail
        outInner.selectedItem = oneItem
        
        // Load is necessary to (simulate) charge items with API content
        outInner.loadDetailOfItem()
        
        let expectRunRequest = expectation(description: "Expect run async request")
        
        DispatchQueue.main.async {
            expectRunRequest.fulfill()
            outInner.removeFavorite(oneItem)
            
            guard let storageFavoriteFake = outInner.localStorageFavoriteItems as? LocalStorageFake else {
                XCTFail("Expected LocalStorageFake instance")
                return
            }
            
            guard let savedItem = storageFavoriteFake.removedItem else {
                XCTFail("Expected saveItem instance captured inside fake")
                return
            }
            
            guard let marketItem = storageFavoriteFake.markedItem else {
                XCTFail("Expected markedItem instance captured inside fake")
                return
            }
            
            XCTAssertEqual(savedItem.identifier, oneItem?.identifier, "Expect same identifier")
            XCTAssertEqual(outInner.items.count, 1, "Expect list of items nil")
            XCTAssertEqual(marketItem.identifier, (outInner.selectedItem as? ViewModelBehavior)?.identifier, "Expected same identifier of selected item" )
            
        }
       
        wait(for: [expectRunRequest])
    }
}
