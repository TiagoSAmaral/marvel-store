//
//  LocalizedStringsStatic.swift
//  BaseProjectTarget
//
//  Created by Tiago Amaral on 23/01/20.
//  Copyright © 2020 Tiago Amaral. All rights reserved.
//

import Foundation

struct LocalizedText {
    
    enum LocalizeTags: String {
        case messageReadme = "message-readme"
    }
    
    static func with(tagName: LocalizeTags) -> String {
        return Bundle.main.localizedString(forKey: tagName.rawValue, value: nil, table: "Localizable-pt-BR")
    }
}
