//
//  LocalStorageFavoritesFake.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

final class LocalStorageFavoritesItemsFake: StorerDelegate {
    
    var savedItem: ViewModelBehavior?
    var removedItem: ViewModelBehavior?
    var markedItem: ViewModelBehavior?
    
    func listItems(from collection: ViewModelBehavior.Type) -> [ViewModelBehavior]? {
        MockerContentProvider().loadManyItem(type: Comic.self)?.compactMap({ $0.isFavorable = true; return $0 })
    }
    
    func save(item: ViewModelBehavior?, into collection: ViewModelBehavior.Type) {
        savedItem = item
    }
    
    func remove(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
        removedItem = item
    }
    
    func markItemFromApi(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
        debugPrint("MARKED ITEM: \(item?.identifier)")
        markedItem = item
    }
}
