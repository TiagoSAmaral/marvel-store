//
//  Request.swift
//  list-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {
    var urlPath: String { get }
    var method: Alamofire.HTTPMethod { get }
    var params: Parameters { get }
    var headers: HTTPHeaders { get }
}
