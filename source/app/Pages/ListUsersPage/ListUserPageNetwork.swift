//
//  ListUserPageNetwork.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

protocol ListUserNetwork {
    func search(with name: String?, handler: ((Result<SearchResult, NetworkError>) -> Void)?)
    func requestListUser(page: Int?, params: [String: Any]?, handler: ((Result<[UserInfoListItem], NetworkError>) -> Void)?)
}

class ListUserPageNetwork: ListUserNetwork, NetworkConectable {
    
    var headerFactory: NetworkHeaderFactory?
    let apiRoutes: ApiRoutes = ApiRoutes()
    
    init(headerFactory: NetworkHeaderFactory) {
        self.headerFactory = headerFactory
    }
    
    func search(with name: String?, handler: ((Result<SearchResult, NetworkError>) -> Void)?) {
        
        let request: RequestApi = RequestApi(
                              urlPath: apiRoutes.path(.getSearchUser(text: name)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: SearchResult.self, handler: handler)
    }
    
    func requestListUser(page: Int?, params: [String: Any]?, handler: ((Result<[UserInfoListItem], NetworkError>) -> Void)?) {
        let request: RequestApi = RequestApi(
                              urlPath: apiRoutes.path(.getListUser(page: page)),
                              method: Alamofire.HTTPMethod.get,
                              params: params,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: [UserInfoListItem].self, handler: handler)
    }
}
