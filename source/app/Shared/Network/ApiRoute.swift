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
        case getListRepoFromUser(text: String?, page: Int?)
        case getUserProfile(text: String?)
    }
    
    static let shared: ApiRoutes = ApiRoutes()
    
    private(set) var baseUrl: String
    
    init() {
        baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    func path(_ path: Paths) -> String {
        switch path {
        case .getListUser(let page):
            
            return baseUrl + "/users?since=\(page ?? 0)&per_page=100"
            
        case .getSearchUser(let text):
            
            guard let text = text else {
                return ""
            }
            
            return baseUrl + "/search/users?q=\(text)"
            
        case .getUserProfile(let text):
            guard let text = text else {
                return ""
            }
            
            return baseUrl + "/users/\(text)"
            
        case .getListRepoFromUser(let text, let page):
            guard let text = text else {
                return ""
            }
            return baseUrl + "/users/\(text)/repos"
        }
    }
}
