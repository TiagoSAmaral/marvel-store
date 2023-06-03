//
//  LocalizedStringsStatic.swift
//  BaseProjectTarget
//
//  Created on 23/01/20.
//

import Foundation

struct LocalizedText {
    
    enum LocalizeTags: String {
        case messageReadme = "message-readme"
        case twitterLogo = "twitter"
        case networkErrorNotDefined = "networkErrorNotDefined"
        case networkOffline = "networkOffline"
        case serverNotResponse = "serverNotResponse"
        case searchPlaceholder = "Buscar usuário por nome"
        case searchButtonLabel = "Buscar"
        case pullToRefreshText = "pullToRefreshText"
        case showRepos = "showRepos"
        case followers = "followers"
        case following = "following"
        case openRepo = "openRepo"
        case close = "close"
        case activeFilter = "activeFilter"
        case clear = "clear"
    }
    
    static func with(tagName: LocalizeTags) -> String {
        return Bundle.main.localizedString(forKey: tagName.rawValue, value: nil, table: "Localizable-pt-BR")
    }
}
