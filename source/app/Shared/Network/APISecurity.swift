//
//  APISecurity.swift
//  list-store
//
//  Created by Tiago Amaral on 29/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import CryptoKit

protocol APISecurer {
    func makeCredential(with timestamp: TimeInterval?) -> APISecurityCredential?
}

protocol APISecurityCredential {
    var publicKey: String { get }
    var timeStamp: Double { get }
    var hash: String { get }
}

class APISecurity: APISecurer {
    
    private var privateKey: String?
    private var publicKey: String?
    private var keyadvisor: KeyAdvisor?
    
    init(keyadvisor: KeyAdvisor? = nil) {
        self.keyadvisor = keyadvisor
    }

    func makeCredential(with timestamp: TimeInterval?) -> APISecurityCredential? {
        return hashComposer(with: timestamp)
    }
    
    private func hashComposer(with timestamp: TimeInterval?) -> APISecurityCredential? {
        guard let privateKey = keyadvisor?.privateKeyApi,
              let publicKey = keyadvisor?.publicKeyApi,
              let timestamp = timestamp,
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
}
