//
//  GeneralResult.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct GeneralResult<Item: Codable>: Codable, Model {
    let status: String?
    let etag: String?
    var data: PaginateResponse<Item>?
}
