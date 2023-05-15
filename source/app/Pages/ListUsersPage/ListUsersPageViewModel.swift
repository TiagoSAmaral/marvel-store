//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListUserVM where Self: AnyObject {
    var controller: ListUserController? { get }
    func viewDidAppear()
}

protocol SearchHandlerEvents where Self: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
}

class ListUsersPageViewModel: NSObject, ListUserVM, ListDataHandler, SearchHandlerEvents {
    
    weak var controller: ListUserController?
    var listUserNetwork: ListUserNetwork?
    var coordinator: ListUsersCoordinable?
    var items: [UserInfoListItem]?
    let numberOfSection: Int = 1
    
    init(controller: ListUserController, network: ListUserNetwork, coordinator: Coordinator?) {
        self.controller = controller
        self.listUserNetwork = network
        self.coordinator = coordinator as? ListUsersCoordinable
    }
    
    func viewDidAppear() {
        requestUsers()
    }

    lazy var goToUserDetail: (Model) -> Void = { [weak self] user in
        self?.coordinator?.goToUserDetail(with: user)
    }
    
    func requestUsers() {
        listUserNetwork?.requestListUser(page: 0, params: nil, handler: { result in
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
    
    func searchUser(by name: String?) {
        listUserNetwork?.search(with: name, handler: { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.updateView(with: response.items)
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
        
        items = value as? [UserInfoListItem]
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
        searchUser(by: searchBar.text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        requestUsers()
    }
}
