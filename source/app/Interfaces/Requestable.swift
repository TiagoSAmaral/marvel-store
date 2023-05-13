//
//  Request.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    var urlPath: URL { get }
    var method: HTTPMethod { get }
    var params: String { get }
}
