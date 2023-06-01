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
        case getListStore(page: Int?, filter: String?)
        case getSearch(text: String?)
        case getDetailWith(_ identifier: Int?)
    }
    
    static let shared: ApiRoutes = ApiRoutes()
    
    private(set) var baseUrl: String
    private let versionAPIuri: String = "/v1"
    private let accessLevelAPIuri: String = "/public"
    private let resourceComicAPIuri: String = "/comics"
        
    init() {
        baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    func path(_ path: Paths) -> String {
        
        switch path {
            
        case .getListStore(let page, let filter):
            // " .../comics?apikey ..."
            var fullPath = appendAPICredential(into: baseUrl
                .appending(versionAPIuri)
                .appending(accessLevelAPIuri)
                .appending(resourceComicAPIuri)
                .appending("?"))
            return fullPath ?? .empty
        case .getSearch(let text):
            // " .../comics?title=Doom&apikey ..."
            
            return ""
        case .getDetailWith(let identifier):
            // "... comics/515?apikey ..."
            
            return ""
        }
    }
    
    func appendAPICredential(into path: String) -> String? {
        let apiSecurer = APISecurity()
        let credentials = apiSecurer.makeCredential(with: Date().timeIntervalSince1970)
        guard let timeStamp = credentials?.timeStamp,
              let publicKey = credentials?.publicKey,
              let hash = credentials?.hash else {
            return nil
        }
        return path.appending("ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)")
    }
}
