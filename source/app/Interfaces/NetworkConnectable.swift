//
//  NetworkConnectable.swift
//  list-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkConectable: AnyObject {
    func networkRequest<T: Codable>(data: RequestApi?, resultType: T.Type, handler: ((Result<T, NetworkError>) -> Void)?)
}

extension NetworkConectable {
    
    func networkRequest<T: Decodable>(data: RequestApi?, resultType: T.Type, handler: ((Result<T, NetworkError>) -> Void)?) {
        
        guard let data = data, let urlPath = data.urlPath else {
            handler?(.failure(NetworkError.notDefined(text: LocalizedText.with(tagName: .networkErrorNotDefined))))
            return
        }
        
        AF.request(urlPath, method: data.method, headers: [:], requestModifier: { $0.timeoutInterval = 15; $0.cachePolicy = .reloadRevalidatingCacheData }).responseDecodable(of: resultType.self) { response in
            switch response.result {
            case .success(let result):
                handler?(.success(result))
            case .failure(let error):
                handler?(.failure(NetworkError.makeError(with: error.responseCode, description: error.errorDescription)))
            }
        }
    }
}
