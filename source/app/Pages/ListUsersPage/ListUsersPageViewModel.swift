//
//  PageViewModel.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListUsersPageViewModel: NSObject, ViewModelHandlerEventsControllerDelegate, ListDataHandler, SearchHandlerEvents {
    
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
            controller?.startLoading()
            requestUsers()
            return
        }
    }

    lazy var goToUserDetail: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToUserDetail(with: data)
    }
    
    func requestUsers() {
        network?.requestListUser(page: 0, params: nil, handler: { result in
            DispatchQueue.main.async { [weak self] in
                
                switch result {
                case .success(let users):
                    self?.updateView(with: users)
                    self?.controller?.stopLoading(onFinish: nil)
                case .failure(let error):
                    self?.controller?.stopLoading {
                        self?.controller?.presentAlert(with: nil, and: error.message, handler: nil)
                    }
                }
            }
        })
    }
    
    func searchUser(by name: String?) {
        controller?.startLoading()
        network?.search(with: name, handler: { result in
            DispatchQueue.main.async { [weak self] in
                
                switch result {
                case .success(let response):
                    self?.controller?.stopLoading(onFinish: nil)
                    self?.updateView(with: response)
                case .failure(let error):
                    self?.controller?.stopLoading {
                        self?.controller?.presentAlert(with: nil, and: error.message, handler: nil)
                    }
                }
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
        requestUsers()
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
        controller?.startLoading()
        searchUser(by: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        controller?.startLoading()
        requestUsers()
    }
}
