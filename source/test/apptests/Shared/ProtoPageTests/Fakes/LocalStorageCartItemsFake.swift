//
//  LocalStorageCartItemsFake.swift
//  marvel-store
//
//  Created by Tiago Amaral on 11/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

final class LocalStorageCartItemsFake: StorerDelegate {
    func listItems(from collection: ViewModelBehavior.Type) -> [ViewModelBehavior]? {
        MockerContentProvider().loadManyItem(type: Comic.self)?.compactMap({ $0.isIntoCart = true; return $0 })
    }
    
    func save(item: ViewModelBehavior?, into collection: ViewModelBehavior.Type) {
    }
    
    func remove(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
    }
    
    func markItemFromApi(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
    }
}
