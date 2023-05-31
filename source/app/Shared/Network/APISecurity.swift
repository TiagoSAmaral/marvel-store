//
//  APISecurity.swift
//  marvel-store
//
//  Created by Tiago Amaral on 29/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import CryptoKit

/**
  APISecurity is responsable by get the private and public API keys and generate a MD5 Hash.
 */

protocol APISecurer {
    func makeCredential() -> APISecurityCredential?
}

protocol APISecurityCredential {
    var publicKey: String { get }
    var timeStamp: Double { get }
    var hash: String { get }
}

struct APISecurityPayload: APISecurityCredential {
    var publicKey: String
    var timeStamp: Double
    var hash: String
}

class APISecurity: APISecurer {
    
    private var privateKey: String?
    private var publicKey: String?

    func makeCredential() -> APISecurityCredential? {
        
        takeLocalKeys()
        let timestamp = NSDate().timeIntervalSince1970
        
        guard let privateKey = privateKey,
              let publicKey = publicKey,
              let dataValues = "\(timestamp)\(privateKey)\(publicKey)".data(using: .utf8) else {
            return nil
        }
        
        let digest = Insecure.MD5.hash(data: dataValues)
        
        let md5hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        
        let credentials = APISecurityPayload(publicKey: publicKey, timeStamp: timestamp, hash: md5hash)
        
        return credentials
    }
    
    private func takeLocalKeys() {
        privateKey = Bundle.main.object(forInfoDictionaryKey: "API_MARVEL_PRIVATE_KEY") as? String ?? ""
        publicKey = Bundle.main.object(forInfoDictionaryKey: "API_MARVEL_PUBLIC_KEY") as? String ?? ""
    }
}

