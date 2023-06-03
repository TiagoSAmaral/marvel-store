//
//  RequestParams.swift
//  marvel-store
//
//  Created by Tiago Amaral on 02/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct RequestParams: NetworkRequestParameters {
    var identifier: Int?
    var search: String?
    var filterSinceYear: Int?
    var sincePage: Int?
    var layoutView: LayoutView?
}
