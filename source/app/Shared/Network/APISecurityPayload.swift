//
//  APISecurityPayload.swift
//  list-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct APISecurityPayload: APISecurityCredential {
    var publicKey: String
    var timeStamp: Double
    var hash: String
}
