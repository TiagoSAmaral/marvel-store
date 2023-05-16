//
//  RepoListItem.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct RepoListemItem: Codable, Model {
    let identifier: Int?
    let name: String?
    let description: String?
    let visibility: String?
    let startsCount: Int?
    let forksCount: Int?
    let htmlUrl: String?
    let language: String?
    
    var layout: LayoutView?
    var action: ((Model?) -> Void)?
    
    enum CodingKeys: String, CodingKey {
        case name, description, language, visibility
        case identifier = "id"
        case startsCount = "stargazers_count"
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
    }
}
