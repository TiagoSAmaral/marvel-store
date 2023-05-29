//
//  Request.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

struct RequestApi {
    var urlPath: String
    var method: Alamofire.HTTPMethod
    var params: [String: Any]?
    var headers: Alamofire.HTTPHeaders?
}
