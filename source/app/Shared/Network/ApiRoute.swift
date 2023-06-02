//
//  ApiRoute.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct ApiRoutes {
    
    enum Paths {
        case getSearch(content: String?, filter: Int?, page: Int?)
        case getListStore(filter: Int?, page: Int?)
        case getDetailWith(_ identifier: Int?)
    }
    
    static let shared: ApiRoutes = ApiRoutes()
    
    func path(_ path: Paths) -> String {
        
        switch path {
            
        case .getSearch(let text, let filter, let page):
            let urlPathBuilder: URLPathBuildable = URLPathBuilder(apiSecurer: APISecurity())
            urlPathBuilder.makeUrlBase()
            urlPathBuilder.makeURLWithSearch(title: text)
            urlPathBuilder.makeURLWithFilterYear(filter: filter)
            urlPathBuilder.makeURLWithFrom(page: page)
            urlPathBuilder.makeSecurityAPI()
            
            return urlPathBuilder.takeProduct() ?? .empty
            
        case .getListStore( let filter, let page):
            let urlPathBuilder: URLPathBuildable = URLPathBuilder(apiSecurer: APISecurity())
            urlPathBuilder.makeUrlBase()
            urlPathBuilder.makeURLWithFilterYear(filter: filter)
            urlPathBuilder.makeURLWithFrom(page: page)
            urlPathBuilder.makeSecurityAPI()
            
            return urlPathBuilder.takeProduct() ?? .empty

        case .getDetailWith(let identifier):
            let urlPathBuilder: URLPathBuildable = URLPathBuilder(apiSecurer: APISecurity())
            urlPathBuilder.makeUrlBase()
            urlPathBuilder.makeUrlTakeWith(identifier: identifier)
            urlPathBuilder.makeSecurityAPI()
            
            return urlPathBuilder.takeProduct() ?? .empty
        }
    }
}

