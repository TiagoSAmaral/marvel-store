//
//  LocalizedStringsStatic.swift
//  BaseProjectTarget
//
//  Created on 23/01/20.
//

import Foundation

struct LocalizedText {
    
    enum LocalizeTags: String {
        case networkErrorNotDefined // = "networkErrorNotDefined"
        case networkOffline // = "networkOffline"
        case serverNotResponse // = "serverNotResponse"
        case pullToRefreshText // = "pullToRefreshText"
        case close // = "close"
        case activeFilter // = "activeFilter"
        case clear // = "clear"
        case storeTitle // = "storeTitle"
        case favoriteTitle // = "favoriteTitle"
        case cartTitle
        case searchTitle
        case makeFavorite
        case addToCart
        case unMakeFavorite
        case RemoveToCart
        case digitalPrice
        case printPrice
    }
    
    static func with(tagName: LocalizeTags) -> String {
        return Bundle.main.localizedString(forKey: tagName.rawValue, value: nil, table: "Localizable-pt-BR")
    }
}
