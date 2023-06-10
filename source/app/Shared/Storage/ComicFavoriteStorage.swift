//
//  Storage.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

final class ComicFavoriteStorage {

    static let main = ComicFavoriteStorage()

    func listComics() -> [ViewModelBehavior]? {
        RealmInstance.main.realm?.objects(Comic.self).where {
            $0.isFavorable == true
        }.compactMap({$0})
        
    }
    
    func save(comic: Model?) {
        
        guard let comic = comic as? Comic, let identifier = comic.identifier else {
            return
        }
        
        guard let cachedComic = RealmInstance.main.realm?.objects(Comic.self).filter("identifier == \(identifier)").first else {
            comic.isFavorable = true
            try? RealmInstance.main.realm?.write {
                RealmInstance.main.realm?.add(comic)
            }
            return
        }
        try? RealmInstance.main.realm?.write {
            cachedComic.isFavorable = true
        }
    }
    
    func remove<T: Object>(comic: ViewModelBehavior?, collection: T.Type) {
        
        guard let comic = comic,
              let identifier = comic.identifier else {
            return
        }
        
        guard var cachedComic = RealmInstance.main.realm?.objects(collection.self).filter("identifier == \(identifier)").first as? ViewModelBehavior else {
            return
        }
        try? RealmInstance.main.realm?.write {
            cachedComic.isFavorable = false
        }
    }
    
    func get<T: Object>(item: ViewModelBehavior?, collection: T.Type) -> T? {
        guard let identifier = item?.identifier else {
            return nil
        }
        return RealmInstance.main.realm?.objects(collection.self).filter( "isFavorable == true").filter("identifier ==\(identifier)").first
    }
    
    func markItemFromApi(item: Model?) {
        guard let comic = item as? Comic, let identifier = comic.identifier else {
            return
        }
        let value = RealmInstance.main.realm?.objects(Comic.self).filter("identifier == \(identifier)").first?.isFavorable ?? false
        try? RealmInstance.main.realm?.write {
            comic.isFavorable = value
        }
    }
}
