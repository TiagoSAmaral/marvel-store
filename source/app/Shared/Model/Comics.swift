//
//  UserDetailProfile.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct Comic: Codable, ViewModelBehavior, Model {
    let identifier: Int?
    let issueNumber: Double?
    let thumbnail: ComicImage?
    let images: [ComicImage]?
    let title: String?
    let description: String?
    let prices: [ComicPrice]?

    var layout: LayoutView?
    var action: ((Model?) -> Void)?

    enum CodingKeys: String, CodingKey {
        case issueNumber, thumbnail, images, title, description, prices
        case identifier = "id"
    }
}

struct ComicImage: Codable {
    let path: String?
    let fileExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

struct ComicPrice: Codable {
    let type: String?
    let price: Double?
}
