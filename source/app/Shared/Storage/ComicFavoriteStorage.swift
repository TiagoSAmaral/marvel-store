//
//  Storage.swift
//  list-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

final class ComicFavoriteStorage: StorerDelegate {
    
    func listItems(from collection: ViewModelBehavior.Type) -> [ViewModelBehavior]? {
        RealmInstance.main.realm?.objects(collection.self).filter("isFavorable == true").compactMap({ return $0 as? ViewModelBehavior})
    }
    
    func save(item: ViewModelBehavior?, into collection: ViewModelBehavior.Type) {
        guard var item = item, let identifier = item.identifier else {
            return
        }
        guard var cachedComic = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier)").first as? ViewModelBehavior else {

            try? RealmInstance.main.realm?.write {
                item.isFavorable = true
                RealmInstance.main.realm?.add(item)
            }
            return
        }
        try? RealmInstance.main.realm?.write {
            cachedComic.isFavorable = true
        }
    }
    
    func remove(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
        guard let identifier = item?.identifier else {
            return
        }

        guard var cachedItem = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier)").first as? ViewModelBehavior else {
            return
        }
        try? RealmInstance.main.realm?.write {
            cachedItem.isFavorable = false
        }
    }
    
    func markItemFromApi(item: ViewModelBehavior?, from collection: ViewModelBehavior.Type) {
        guard var item = item,
              let identifier = item.identifier,
              let existentItem = RealmInstance.main.realm?.objects(collection.self)
            .filter("identifier == \(identifier) AND isFavorable == true").first as? ViewModelBehavior else {
            return
        }

        try? RealmInstance.main.realm?.write {
            item.isFavorable = existentItem.isFavorable
        }
    }
    
//    func list(from collection: GenericT) -> [GenericT]? {
//        RealmInstance.main.realm?.objects(collection.self).filter("isFavorable == true")
//    }
    
//    func save(item: ViewModelBehavior?, from collection: T.Type) {
//
//        guard var item = item, let identifier = item.identifier else {
//            return
//        }
//        guard var cachedComic = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier)").first as? ViewModelBehavior else {
//
//            try? RealmInstance.main.realm?.write {
//                item.isFavorable = true
//                RealmInstance.main.realm?.add(item)
//            }
//            return
//        }
//        try? RealmInstance.main.realm?.write {
//            cachedComic.isFavorable = true
//        }
//    }
    
//    func remove(item: ViewModelBehavior?, from collection: T.Type) {
//
//        guard let identifier = item?.identifier else {
//            return
//        }
//
//        guard var cachedItem = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier)").first as? ViewModelBehavior else {
//            return
//        }
//        try? RealmInstance.main.realm?.write {
//            cachedItem.isFavorable = false
//        }
//    }
  
//    func markItemFromApi(item: ViewModelBehavior?, from collection: T.Type) {
//        guard var item = item,
//              let identifier = item.identifier,
//              let existentItem = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier) AND isFavorable == true").first as? ViewModelBehavior else {
//            return
//        }
//
//        try? RealmInstance.main.realm?.write {
//            item.isFavorable = existentItem.isFavorable
//        }
//    }
}
