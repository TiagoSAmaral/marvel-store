//
//  MockerContent.swift
//  marvel-store
//
//  Created by Tiago Amaral on 31/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

public final class MockerContentProvider {
    
    // Timestamp to generate is 1
    public let mockMD25Tests: String = Bundle.main.object(forInfoDictionaryKey: "MOCK_MD5_TESTS") as? String ?? ""
    
    func loadMockFrom<T: Codable>(fileName: String) -> T? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
