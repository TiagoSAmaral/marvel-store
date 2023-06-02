//
//  URLPathBuilder.swift
//  marvel-store
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class URLPathBuilder: URLPathBuildable {
    
    private var product: String?
    private var apiSecurer: APISecurer?
    private let versionAPIuri: String = "/v1"
    private let accessLevelAPIuri: String = "/public"
    private let resourceComicAPIuri: String = "/comics"
    
    init(apiSecurer: APISecurer?) {
        self.apiSecurer = apiSecurer
    }
    
    func makeUrlBase() {
        product = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
        product?.append(versionAPIuri)
        product?.append(accessLevelAPIuri)
        product?.append(resourceComicAPIuri)
        product?.append("?")
    }
    
    func makeURLWithFilterYear(filter value: Int?) {
        guard let value = value else {
            return
        }
        putAmpersandIfNecessary()
        product?.append("startYear=\(value)")
    }

    func makeURLWithFrom(page value: Int?) {
        guard let value = value else {
            return
        }
        putAmpersandIfNecessary()
        product?.append("offset=\(value)")
    }

    func makeURLWithSearch(title value: String?) {
        guard let value = value else {
            return
        }
        putAmpersandIfNecessary()
        product?.append("title=\(value)")
    }
    
    func makeUrlTakeWith(identifier value: Int?) {
        guard var product = product, let value = value else {
            return
        }
        if product.last == "?" {
            product.removeLast()
        }
        product.append("/\(value)")
        product.append("?")
        self.product = product
    }

    func makeSecurityAPI() {
        let credentials = apiSecurer?.makeCredential(with: Date().timeIntervalSince1970)
        guard let timeStamp = credentials?.timeStamp,
              let publicKey = credentials?.publicKey,
              let hash = credentials?.hash else {
            return
        }
        putAmpersandIfNecessary()
        self.product?.append("ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)")
    }

    func takeProduct() -> String? {
        product
    }
    
    private func putAmpersandIfNecessary() {
        guard var product = product else {
            return
        }
        if product.last != "?" {
            self.product?.append("&")
        }
    }
}
