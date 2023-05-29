//
//  SearchHandlerEvents.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol SearchHandlerEvents where Self: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
}
