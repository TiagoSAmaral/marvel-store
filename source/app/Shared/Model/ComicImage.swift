//
//  ComicImage.swift
//  list-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import RealmSwift

class ComicImage: Object, Codable {
    @Persisted var path: String?
    @Persisted var fileExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
