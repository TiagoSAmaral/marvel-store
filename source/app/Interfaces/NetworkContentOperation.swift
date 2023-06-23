//
//  NetworkContentOperation.swift
//  list-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol NetworkContentOperation {
    func requestContentWith(param: NetworkRequestParameters, handler: GeneralResultHandler?)
}
