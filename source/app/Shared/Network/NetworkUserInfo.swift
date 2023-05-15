//
//  ListUserPageNetwork.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Alamofire
import Foundation

typealias ResultUsersItemOrError = Result<[UserDetailProfile], NetworkError>

protocol NetworkUserInfoOperation {
    func search(with name: String?, handler: ((Result<[UserDetailProfile], NetworkError>) -> Void)?)
    func requestListUser(page: Int?, params: [String: Any]?, handler: ((Result<[UserDetailProfile], NetworkError>) -> Void)?)
    func requestUser(with name: String?, handler: ((ResultUsersItemOrError) -> Void)?)
}

class NetworkUserInfo: NetworkUserInfoOperation, NetworkConectable {
    
    var headerFactory: NetworkHeaderFactory?
    
    init(headerFactory: NetworkHeaderFactory) {
        self.headerFactory = headerFactory
    }
    
    func search(with name: String?, handler: ((Result<[UserDetailProfile], NetworkError>) -> Void)?) {
        
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getSearchUser(text: name)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: SearchResult.self) { response in
            switch response {
            case .success(var result):
                
                guard var item = result.items else {
                    handler?(.failure(NetworkError.makeError(with: nil, description: nil)))
                    return
                }
                
                let itemsWithLayout: [UserDetailProfile] = item.compactMap { (item: UserDetailProfile) in
                    item.layout = .userListItem
                    return item
                }
                 
                handler?(.success(itemsWithLayout))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func requestListUser(page: Int?, params: [String: Any]?, handler: ((Result<[UserDetailProfile], NetworkError>) -> Void)?) {
        let request: RequestApi = RequestApi(
                              urlPath: ApiRoutes.shared.path(.getListUser(page: page)),
                              method: Alamofire.HTTPMethod.get,
                              params: params,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: [UserDetailProfile].self) { [weak self] result in

            var itemsWithLayout: [UserDetailProfile] = []
            switch result {
            case .success(let items):
                
                itemsWithLayout = items.compactMap { item in
                    var mutableItem = item
                    item.layout = .userListItem
                    return mutableItem
                }
                
                handler?(.success(itemsWithLayout))
                
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func requestUser(with name: String?, handler: ((ResultUsersItemOrError) -> Void)?) {
        
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getUserProfile(text: name)),
                              method: Alamofire.HTTPMethod.get,
                              params: nil,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: UserDetailProfile.self) { response in
            switch response {
            case .success(var user):
                user.layout = .userInfo
                handler?(.success([user]))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func requestUserRepos(name: String?, page: Int?, params: [String: Any]?, handler: ((Result<[RepoListemItem], NetworkError>) -> Void)?) {
        let request: RequestApi = RequestApi(
            urlPath: ApiRoutes.shared.path(.getListRepoFromUser(text: name, page: page)),
                              method: Alamofire.HTTPMethod.get,
                              params: params,
                              headers: headerFactory?.makeHeader())
        networkRequest(data: request, resultType: [RepoListemItem].self) { result in
            
            switch result {
            case .success(var items):
                
                let itemsLayoutMaped: [RepoListemItem] = items.compactMap { item in
                    var mutableItem = item
                    mutableItem.layout = .repoListItem
                    return mutableItem
                }
                handler?(.success(itemsLayoutMaped))
            case .failure(let error):
                handler?(.failure(error) )
            }
            
        }
    }
}
