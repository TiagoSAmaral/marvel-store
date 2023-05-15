//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ListResposVM {
    func viewDidAppear()
}

class ListReposPageViewModel: NSObject, ViewModelHandlerEventsControllerDelegate, ListDataHandler {
    
    weak var controller: ListReposController?
    var network: NetworkUserInfoOperation?
    var coordinator: ListReposCoordinable?
    var valueToRequest: Model?
    var items: [RepoListemItem]?
    let numberOfSection: Int = 1
    
    init(controller: ListReposController, network: NetworkUserInfoOperation, coordinator: Coordinator?) {
        self.controller = controller
        self.network = network
        self.coordinator = coordinator as? ListReposCoordinable
    }
    
    func viewDidAppear() {
        
        guard let items = items, !items.isEmpty else {
            requestRepos()
            return
        }
    }

    lazy var goToUserDetail: (Model?) -> Void = { [weak self] data in
        self?.coordinator?.goToRepo(with: data)
    }
    
    func requestRepos() {
        
        guard let valueToRequest = valueToRequest as? UserDetailProfile, let login = valueToRequest.login  else {
            return
        }
        
        network?.requestUserRepos(name: login, page: 0, params: nil) { result in
            
            switch result {
            case .success(let users):
                DispatchQueue.main.async { [weak self] in
                    self?.updateView(with: users)
                }
            case .failure(let error):
                debugPrint(error.message)
            }
        }
    }
    
    func updateView(with value: [Model]?) {
        
        guard let value = value else {
            return
        }
        
        items = value as? [RepoListemItem]
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
}
