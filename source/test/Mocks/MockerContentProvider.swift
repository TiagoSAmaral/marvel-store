//
//  MockerContent.swift
//  marvel-store
//
//  Created by Tiago Amaral on 31/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

public final class MockerContentProvider: KeyAdvisor {
    var publicKeyApi: String {
        // Provider value to test
//        .empty
        "p1"
    }
    
    var privateKeyApi: String {
        // Provider value to test
//        .empty
        "s2"
    }

    func loadOneItem<T: Codable>(type: T.Type) -> T? {
        loadMockFrom(fileName: "oneComic")
    }
    
    func loadManyItem<T: Codable>(type: T.Type) -> [T]? {
        loadMockFrom(fileName: "listComic")
    }
    
    private func loadMockFrom<T: Codable>(fileName: String) -> T? {
        guard let filePath = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json"), // Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            return nil
        }
        
        do {
            let content = try JSONDecoder().decode(T.self, from: data)
            return content
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
