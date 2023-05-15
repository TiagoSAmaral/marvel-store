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
    let owner: UserDetailProfile?
    let description: String?
    let startsCount: Int?
    let forksCount: Int?
    let watchersCount: Int?
    let htmlUrl: String?
    
    var layout: LayoutView? = .repoListItem
    var action: ((Model?) -> Void)?
    
    enum CodingKeys: String, CodingKey {
        case name, owner, description
        case identifier = "id"
        case startsCount = "stargazers_count"
        case forksCount = "forks_count"
        case watchersCount = "watchers_count"
        case htmlUrl = "html_url"
    }
}
