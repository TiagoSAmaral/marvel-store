//
//  NetworkRequestParam.swift
//  marvel-store
//
//  Created by Tiago Amaral on 02/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol NetworkRequestParameters {
    var identifier: Int? { get }
    var search: String? { get }
    var filterSinceYear: Int? { get }
    var sincePage: Int? { get }
    var layoutView: LayoutView? { get }
}
