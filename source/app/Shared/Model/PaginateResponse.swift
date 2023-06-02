//
//  PaginateResponse.swift
//  marvel-store
//
//  Created by Tiago Amaral on 29/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct GeneralResult<Item: Codable>: Codable, Model {
    let code: Int?
    let status: String?
    let etag: String?
    var data: PaginateResponse<Item>?
}

struct PaginateResponse<Item: Codable>: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    var results: [Item]?
}
