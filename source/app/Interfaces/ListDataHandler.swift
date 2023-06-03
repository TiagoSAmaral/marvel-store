//
//  ListDataHandler.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol ListDataHandler {
    func updateContent()
    func numberOfItemsBy(section: Int?) -> Int
    func numberOfSections() -> Int
    func dataBy(indexPath: IndexPath) -> Model?
    func nextPage()
}

extension ListDataHandler {
    func nextPage() {}
}
