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
typealias ComicResult = Result<GeneralResult<Comic>, NetworkError>
typealias GeneralResultHandler = ((ComicResult) -> Void)

class NetworkRequestContent: NetworkContentOperation, NetworkConectable {
    
    func requestContentWith(param: NetworkRequestParameters, handler: GeneralResultHandler?) {
        
        let urlPathBuilder: URLPathBuildable = URLPathBuilder(apiSecurer: APISecurity())
        
        let apiPath = urlPathBuilder.makeUrlWith(identifier: param.identifier,
                                                 search: param.search,
                                                 filterSince: param.filterSinceYear,
                                                 startFrom: param.sincePage)
        
        let request: RequestApi = RequestApi(urlPath: apiPath,
                                             method: Alamofire.HTTPMethod.get)
        handlerRequest(data: request,
                       resultType: GeneralResult<Comic>.self,
                       layout: param.layoutView,
                       handler: handler)
    }
    
    func handlerRequest(data: RequestApi, resultType: GeneralResult<Comic>.Type, layout: LayoutView?, handler: GeneralResultHandler?) {
        networkRequest(data: data, resultType: resultType) { [weak self] result in
            self?.responseHandler(result: result, handler: handler, layout: layout)
        }
    }
    
    func responseHandler(result: ComicResult, handler: GeneralResultHandler?, layout: LayoutView?) {
        switch result {
        case .success(var genericResponse):
            
            guard let items = genericResponse.data?.results else {
                handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                return
            }
            genericResponse.data?.results = defineLayout(at: items, layoutView: layout)
            handler?(.success(genericResponse))
            
        case .failure(let error):
            handler?(.failure(error))
        }
    }
    
    func defineLayout(at items: [Comic], layoutView: LayoutView?) -> [Comic] {
        let itemsWithLayout: [Comic] = items.compactMap { (item: Comic) -> Comic in
            let mutableItem = item
            mutableItem.layout = layoutView
            return mutableItem
        }
        return itemsWithLayout
    }
}
