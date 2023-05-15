//
//  ApiRoute.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct ApiRoutes {
    
    enum Paths {
        case getListUser(page: Int?)
        case getSearchUser(text: String?)
        case getListRepoFromUser(text: String)
        case getUserProfile(text: String)
    }
    
//    static let shared = ApiRoutes()
    private(set) var baseUrl: String
    
    init() {
        baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    func path(_ path: Paths) -> String {
        switch path {
        case .getListUser(let page):
            
            guard let page = page else {
                return baseUrl + "/users"
            }
            
            return baseUrl + "/users?since=\(page)&per_page=100"
            
        case .getSearchUser(let text):
            
            guard let text = text else {
                return ""
            }
            
            return baseUrl + "/search/users?q=\(text)"
            
        default:
            return ""
        }
    }
}
