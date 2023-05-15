//
//  UserDetailPageNetwork.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

protocol UserDetailNetwork {
    func requestUser(with name: String?, handler: ((Result<UserDetailProfile, NetworkError>) -> Void)?)
}

class UserDetailPageNetwork: UserDetailNetwork, NetworkConectable {

    var headerFactory: NetworkHeaderFactory?
    let apiRoutes: ApiRoutes = ApiRoutes()
    
    init(headerFactory: NetworkHeaderFactory) {
        self.headerFactory = headerFactory
    }
    
    func requestUser(with name: String?, handler: ((Result<UserDetailProfile, NetworkError>) -> Void)?) {
        
        let request: RequestApi = RequestApi(
            urlPath: apiRoutes.path(.getUserProfile(text: name)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: UserDetailProfile.self, handler: handler)
    }
}
