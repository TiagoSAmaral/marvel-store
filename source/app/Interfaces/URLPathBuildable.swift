//
//  URLPathBuildable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol URLPathBuildable {
    func makeUrlBase()
    func makeURLWithFilterYear(filter value: Int?)
    func makeURLWithFrom(page value: Int?)
    func makeURLWithSearch(title value: String?)
    func makeSecurityAPI()
    func makeUrlTakeWith(identifier value: Int?)
    func takeProduct() -> String?
}
