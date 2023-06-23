//
//  KeyAdvisor.swift
//  list-storeTests
//
//  Created by Tiago Amaral on 07/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol KeyAdvisor {
    var publicKeyApi: String { get }
    var privateKeyApi: String { get }
}
