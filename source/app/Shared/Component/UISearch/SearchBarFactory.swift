//
//  SearchBarFactory.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct SearchBarFactory {
    
    static func makeSearch() -> UISearchController {
        let controller = UISearchController()
        let searchBar =
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = LocalizedText.with(tagName: .searchPlaceholder)
        return controller
    }
}
