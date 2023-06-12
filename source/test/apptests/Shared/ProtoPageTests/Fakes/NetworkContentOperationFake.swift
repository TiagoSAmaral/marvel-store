//
//  NetworkContentOperaionFake.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import XCTest
import Foundation

enum ResponseSelector {
    case successList
    case successOne
    case failList
    case failOne
}

final class NetworkContentOperationFake: NetworkContentOperation {
    
    var selectorResultType: ResponseSelector
    var paramRequestIntercepted: NetworkRequestParameters?
    
    init(selectorResultType: ResponseSelector = .successList) {
        self.selectorResultType = selectorResultType
    }
    
    func requestContentWith(param: NetworkRequestParameters, handler: GeneralResultHandler?) {
        paramRequestIntercepted = param
        switch selectorResultType {
        case .successList:
            guard let response = MockerContentProvider().loadListContent(type: GeneralResult<Comic>.self) else {
                XCTFail("Content mock not found")
                return
            }
            handler?(.success(response))
        case .successOne:
            guard let response = MockerContentProvider().loadOneContent(type: GeneralResult<Comic>.self) else {
                XCTFail("Content mock not found")
                return
            }
            handler?(.success(response))
        case .failList, .failOne:
            handler?(.failure(NetworkError.makeError(with: 400)))
        }
    }    
}
