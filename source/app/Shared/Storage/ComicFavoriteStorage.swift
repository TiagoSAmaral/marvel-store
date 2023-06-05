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

    func listComic() -> [Comic]? {
        RealmInstance.main.realm?.objects(Comic.self).filter({$0.isFavorable == true}).compactMap({$0})
    }
    
    func save(comic: Model?) {
        
        guard let comic = comic as? Comic else {
            return
        }
        
        guard let cachedComic = RealmInstance.main.realm?.objects(Comic.self).first else {
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
    
    func remove(comic: Model?) {
        
        guard let comic = comic as? Comic else {
            return
        }
        
        try? RealmInstance.main.realm?.write {
            if let comicToDelete = RealmInstance.main.realm?.objects(Comic.self).where({ $0.identifier == comic.identifier }) {
                RealmInstance.main.realm?.delete(comicToDelete)
            }
        }
    }
    
    func get(comic identifier: Int?) -> Comic? {
        RealmInstance.main.realm?.objects(Comic.self).filter({ $0.isFavorable == true}).first
    }
    
    func isFavorite(comic: Comic) -> Bool {
        RealmInstance.main.realm?.objects(Comic.self).filter({ $0.identifier == comic.identifier}).first != nil
    }
}
