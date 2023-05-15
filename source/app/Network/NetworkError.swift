//
//  NetworkError.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum NetworkError: Error {

    case offline(text: String)
    case badRequest(text: String)
    case notFound(text: String)
    case notDefined(text: String)

    var message: String {
        switch self {
        case .badRequest(let text), .notFound(let text), .offline(let text), .notDefined(text: let text):
            return text
        }
    }

    static func makeError(with status: Int?, description: String?) -> NetworkError {
 
        guard let status = status, let description = description else {
            return .notDefined(text: LocalizedText.with(tagName: .networkErrorNotDefined))
        }
        
        if status == -1 {
            return .offline(text: LocalizedText.with(tagName: .networkOffline))
        }
        
        if 400 ... 499 ~= status {
            return .notDefined(text: description)
        }
        
        if status > 499 {
            return .notDefined(text: LocalizedText.with(tagName: .serverNotResponse))
        }
        
        return .notDefined(text: LocalizedText.with(tagName: .networkErrorNotDefined))
    }
}
