//
//  UserDetailProfile.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

struct UserInfo: Codable, Model {
    let login: String?
    let identifier: Int?
    let avatarURL: String
    let reposURL: String?
    let name: String?
    let blog: String?
    let location: String?
    let email: String?
    let bioText: String?
    let twitterUsername: String?
    let followers: Int?
    let following: Int?
    
    var layout: LayoutView? = .userInfo
    var action: ((Model) -> Void)?

    enum CodingKeys: String, CodingKey {
        case login, name, blog, location, email, followers, following
        case bioText = "bio"
        case avatarURL = "avatar_url"
        case identifier = "id"
        case reposURL = "repos_url"
        case twitterUsername = "twitter_username"
    }
}

/*
 
 "id": 929261,
 "login": "tangollama",
 "avatar_url": "https://avatars.githubusercontent.com/u/929261?v=4",
 "name": "Joel Worrall",
 "bio": "Head of product @thebi ...
 "blog": "http://joelworrall.com",
 "email: String?
 "twitter_username": ""
 "followers": 157,
 "following": 55,
 "repos_url": "https://api.github.com/users/tangollama/repos",
 "location": "Harrisburg, PA",
 */
