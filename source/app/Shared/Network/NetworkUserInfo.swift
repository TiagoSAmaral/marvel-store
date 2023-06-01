//
//  ListUserPageNetwork.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

// Handler type of decode json here.
typealias GeneralResultHandler = ((Result<GeneralResult<Comic>, NetworkError>) -> Void)

protocol NetworkContentOperation {
    func search(with name: String?, handler: GeneralResultHandler?)
    func requestList(page: Int?, filter: String?, params: [String : Any]?, handler: GeneralResultHandler?)
    func requestDetail(identifier: Int?, params: [String: Any]?, handler: GeneralResultHandler?)
}

class NetworkUserInfo: NetworkContentOperation, NetworkConectable {
    
    var headerFactory: NetworkHeaderFactory?
    
    init(headerFactory: NetworkHeaderFactory?) {
        self.headerFactory = headerFactory
    }
    
    func search(with name: String?, handler: GeneralResultHandler?) {
        
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getSearch(text: name)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: GeneralResult<Comic>.self) { response in
            switch response {
            case .success(let result):
                
                guard let items = result.data?.results else {
                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                    return
                }
                
                let itemsWithLayout: [Comic] = items.compactMap { (item: Comic) -> Comic in
                    var mutableItem = item
                    mutableItem.layout = .storelist
                    return mutableItem
                }
                
                var mutableResult = result
                mutableResult.data?.results = itemsWithLayout
                 
                handler?(.success(mutableResult))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func requestList(page: Int?, filter: String?, params: [String : Any]?, handler: GeneralResultHandler?) {
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getListStore(page: page, filter: filter)),
                              method: Alamofire.HTTPMethod.get,
                              params: params,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: GeneralResult<Comic>.self) { result in

            switch result {
            case .success(let genericResponse):
                
                guard let items = genericResponse.data?.results else {
                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                    return
                }
                
                let itemsWithLayout: [Comic] = items.compactMap { (item: Comic) -> Comic in
                    var mutableItem = item
                    mutableItem.layout = .storelist
                    return mutableItem
                }
                
                var mutableResult = genericResponse
                mutableResult.data?.results = itemsWithLayout
                
                handler?(.success(mutableResult))
                
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func requestDetail(identifier: Int?, params: [String: Any]?, handler: GeneralResultHandler?) {
        
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getDetailWith(identifier)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: GeneralResult<Comic>.self) { result in

            switch result {
            case .success(let genericResponse):
                
                guard let items = genericResponse.data?.results else {
                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                    return
                }
                
                let itemsWithLayout: [Comic] = items.compactMap { (item: Comic) -> Comic in
                    var mutableItem = item
                    mutableItem.layout = .storelist
                    return mutableItem
                }
                
                var mutableResult = genericResponse
                mutableResult.data?.results = itemsWithLayout
                
                handler?(.success(mutableResult))
                
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
}
