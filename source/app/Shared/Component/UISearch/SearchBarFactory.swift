//
//  SearchBarFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct SearchBarFactory {
    
    static func makeSearch() -> UISearchController {
        let controller = UISearchController()
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = LocalizedText.with(tagName: .searchTitle)
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }
}
