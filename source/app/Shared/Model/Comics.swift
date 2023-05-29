//
//  UserDetailProfile.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct Comics: Codable, Model {
    let identifier: Int?
    let issueNumber: Int?
    let thumbnail: ComicImage?
    let images: [ComicImages]?
    let title: String?
    let description: String?
    let prices: [ComicPrice]?

    var layout: LayoutView?
    var action: ((Model?) -> Void)?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
    }
}

struct ComicImage: Codable, Model {
    let path: String?
    let extension: String?
}

struct ComicPrice: Codable, Model {
    let type: String?
    let price: Double? 
}
