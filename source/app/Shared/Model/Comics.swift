//
//  UserDetailProfile.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import RealmSwift

class Comic: Object, Codable, ViewModelBehavior, Model {
    @Persisted var identifier: Int?
    @Persisted var issueNumber: Double?
    @Persisted var thumbnail: ComicImage?
    @Persisted var title: String?
    @Persisted var resume: String?
    @Persisted var layout: LayoutView?
    @Persisted var isIntoCart: Bool
    @Persisted var isFavorable: Bool
    @Persisted var images = List<ComicImage>()
    @Persisted var prices = List<ComicPrice>()
    
    var selectAction: ((Model?) -> Void)?
    var addCartAction: ((Model?) -> Void)?
    var removeCartAction: ((Model?) -> Void)?
    var addFavoriteAction: ((Model?) -> Void)?
    var removeFavoriteAction: ((Model?) -> Void)?
    
    enum CodingKeys: String, CodingKey {
        case issueNumber, thumbnail, title
        case prices = "prices"
        case images = "images"
        case identifier = "id"
        case resume = "description"
    }
}
