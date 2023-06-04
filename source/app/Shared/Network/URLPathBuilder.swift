//
//  URLPathBuilder.swift
//  marvel-store
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class URLPathBuilder: URLPathBuildable {
    
    private var product: URLComponents?
    private var apiSecurer: APISecurer?
    private let comicsPath: String = "/v1/public/comics"
    
    init(apiSecurer: APISecurer?) {
        self.apiSecurer = apiSecurer
        makeUrlBase()
    }

    func makeUrlBase() {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            return
        }
        product = URLComponents(string: baseUrl)
        product?.path = comicsPath
    }
    
    func makeUrlWith(identifier: Int?, search titleValue: String?, filterSince year: String?, startFrom page: Int?) -> URL? {
        product?.queryItems = []
        
        if let titleValue = titleValue {
            product?.queryItems?.append(URLQueryItem(name: "title", value: titleValue))
        }
        
        if let year = year {
            product?.queryItems?.append(URLQueryItem(name: "startYear", value: year))
        }
        
        if let page = page {
            product?.queryItems?.append(URLQueryItem(name: "offset", value: "\(page)"))
        }
        
        if let identifier = identifier {
            product?.path.append("/\(identifier)")
        }
        
        applySecurity()
        let productFinal = product?.url
        
        // Reset
        makeUrlBase()
        
        return productFinal
    }
    
    func applySecurity() {
        let credentials = apiSecurer?.makeCredential(with: Date().timeIntervalSince1970)
        guard let timeStamp = credentials?.timeStamp,
              let publicKey = credentials?.publicKey,
              let hash = credentials?.hash else {
            return
        }
        product?.queryItems?.append(contentsOf: [
            URLQueryItem(name: "ts", value: "\(timeStamp)"),
            URLQueryItem(name: "apikey", value: "\(publicKey)"),
            URLQueryItem(name: "hash", value: "\(hash)"),
        ])
    }
    
//    func makeURLWithFilterYear(filter value: Int?) {
//        guard let value = value else {
//            return
//        }
////        putAmpersandIfNecessary()
////        product?.append("startYear=\(value)")
//        product?.queryItems = [URLQueryItem(name: "startYear", value: "\(value)")]
//    }
//
//    func makeURLWithFrom(page value: Int?) {
//        guard let value = value else {
//            return
//        }
////        putAmpersandIfNecessary()
////        product?.append("offset=\(value)")
//        product?.queryItems = [URLQueryItem(name: "offset", value: "\(value)")]
//    }
//
//    func makeURLWithSearch(title value: String?) {
//        guard let value = value else {
//            return
//        }
////        putAmpersandIfNecessary()
////        product?.append("title=\(value)")
//        product?.queryItems = [URLQueryItem(name: "title", value: "\(value)")]
//    }
    
//    func makeUrlTakeWith(identifier value: Int?) {
//        guard var product = product, let value = value else {
//            return
//        }
//        if product.last == "?" {
//            product.removeLast()
//        }
//        product.append("/\(value)")
//        product.append("?")
//        self.product = product
//    }

//    func makeSecurityAPI() {
//        let credentials = apiSecurer?.makeCredential(with: Date().timeIntervalSince1970)
//        guard let timeStamp = credentials?.timeStamp,
//              let publicKey = credentials?.publicKey,
//              let hash = credentials?.hash else {
//            return
//        }
//        putAmpersandIfNecessary()
//        self.product?.append("ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)")
//    }
    
//    private func putAmpersandIfNecessary() {
//        guard var product = product else {
//            return
//        }
//        if product.last != "?" {
//            self.product?.append("&")
//        }
//    }
}
