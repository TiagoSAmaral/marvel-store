//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListResposPageViewModel: NSObject, ViewModelHandlerEventsControllerDelegate, ListDataHandler, SearchHandlerEvents {
    
    weak var controller: ListUserController?
    var network: NetworkUserInfoOperation?
    var coordinator: ListUsersCoordinable?
    var items: [UserDetailProfile]?
    let numberOfSection: Int = 1
    
    init(controller: ListUserController, network: NetworkUserInfoOperation, coordinator: Coordinator?) {
        self.controller = controller
        self.network = network
        self.coordinator = coordinator as? ListUsersCoordinable
    }
    
    func viewDidAppear() {
        
        guard let items = items, !items.isEmpty else {
            requestRepos()
            return
        }
    }

    lazy var goToUserDetail: (Model?) -> Void = { [weak self] user in
        self?.coordinator?.goToUserDetail(with: user)
    }
    
    func requestRepos() {
        network?.requestListUser(page: 0, params: nil, handler: { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async { [weak self] in
                    self?.updateView(with: users)
                }
            case .failure(let error):
                debugPrint(error.message)
            }
        })
    }
    
    func updateView(with value: [Model]?) {
        
        guard let value = value else {
            return
        }
        
        items = value as? [UserDetailProfile]
        controller?.updateView()
    }
    
    func updateContent() {
        requestRepos()
    }
    
// MARK: - ListDataHandler methods
    
    func numberOfItemsBy(section: Int?) -> Int {
        items?.count ?? .zero
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        guard let items = items else {
            return nil
        }
        var item = items[indexPath.row]
        item.action = goToUserDetail
        return item
    }
    
    // MARK: - SearchHandlerEvents
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchUser(by: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        requestUsers()
    }
}
