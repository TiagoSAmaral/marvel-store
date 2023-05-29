//
//  NetworkHeaderFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkHeaderMaker: NetworkHeaderFactory {
    
    var fakeUserTokenInApp: String? {
        nil
    }
    
    func makeHeader() -> HTTPHeaders {

        guard fakeUserTokenInApp != nil else {
            return makeOpenHeader()
        }
        return makeProtectedHeader()
    }
    
    private func makeOpenHeader() -> HTTPHeaders {
        defaultHeader()
    }
    
    private func makeProtectedHeader() -> HTTPHeaders {
        
        var header = defaultHeader()
        header.add(name: "Authorization", value: "")
        return header
    }
    
    private func defaultHeader() -> HTTPHeaders {
        [
            "X-GitHub-Api-Version": "2022-11-28"
        ]
    }
}
