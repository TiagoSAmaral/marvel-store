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
    func requestContentWith(search content: String?, filter: Int?, page: Int?, handler: GeneralResultHandler?)
    func requestDetail(identifier: Int?, params: [String: Any]?, handler: GeneralResultHandler?)
}

class NetworkRequestContent: NetworkContentOperation, NetworkConectable {
    
    func requestContentWith(search content: String?, filter: Int?, page: Int?, handler: GeneralResultHandler?) {
        
        var apiPath: String?
        
        if content != nil {
            apiPath = ApiRoutes.shared.path(.getSearch(content: content, filter: filter, page: page))
        } else {
            apiPath =  ApiRoutes.shared.path(.getListStore(filter: filter, page: page))
        }
 
        let request: RequestApi = RequestApi(urlPath: apiPath, method: Alamofire.HTTPMethod.get)
        handlerRequest(data: request, resultType: GeneralResult<Comic>.self, layout: .listContentLayoutCard, handler: handler)
    }

    func requestDetail(identifier: Int?, params: [String: Any]?, handler: GeneralResultHandler?) {
        let apiPath = ApiRoutes.shared.path(.getDetailWith(identifier))
        let request: RequestApi = RequestApi(urlPath: apiPath, method: Alamofire.HTTPMethod.get)
        handlerRequest(data: request, resultType: GeneralResult<Comic>.self, layout: .detailContentLayoutCard, handler: handler)
    }
    
    func handlerRequest(data: RequestApi, resultType: GeneralResult<Comic>.Type, layout: LayoutView, handler: GeneralResultHandler?) {
        
        networkRequest(data: data, resultType: resultType) { result in
            switch result {
            case .success(let genericResponse):
                
                guard let items = genericResponse.data?.results else {
                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                    return
                }
                
                let itemsWithLayout: [Comic] = items.compactMap { (item: Comic) -> Comic in
                    var mutableItem = item
                    mutableItem.layout = layout
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
