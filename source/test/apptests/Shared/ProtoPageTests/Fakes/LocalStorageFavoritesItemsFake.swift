//
//  LocalStorageFavoritesFake.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

final class LocalStorageFavoritesItemsFake: StorerDelegate {
    func listItems(from collection: ViewModelBehavior.Type) -> [ViewModelBehavior]? {
        nil
    }
    
    func save(item: ViewModelBehavior?, into collection: ViewModelBehavior.Type) {
    }
    
    func remove(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
    }
    
    func markItemFromApi(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
    }
}
