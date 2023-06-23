//
//  YearSelectorViewDataHandlerDelegate.swift
//  list-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol YearSelectorViewDataHandlerDelegate: AnyObject {
    var disableFilterOptions: String? { get }
    var listYearFilter: [String]? { get }
    func receive(value: String?)
}
