//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

class UserDetailPageViewModel: ViewModelHandlerEventsControllerDelegate, ListDataHandler {
    
    weak var controller: UserDetailController?
    var userDetailNetwork: NetworkUserInfoOperation?
    var coordinator: UserDetailCoordinable?
    var valueToRequest: Model?
    var items: [Model]?
    var numberOfSection: Int = 1
    
    init(controller: UserDetailController? = nil) {
        self.controller = controller
    }
    
    func viewDidAppear() {
        
        guard let items = items, !items.isEmpty else {
            requestUserInfo()
            return
        }
    }
    
    func requestUserInfo() {
        guard let dataToSearch = valueToRequest as? UserDetailProfile else {
            return
        }
        
        controller?.startLoading()
        userDetailNetwork?.requestUser(with: dataToSearch.login) { result in
            DispatchQueue.main.async { [weak self] in
                self?.controller?.stopLoading()
                switch result {
                case .success(let items):
                    self?.items = items
                    self?.updateContent()
                case .failure(let error):
                    debugPrint(error.message)
                }
            }
        }
    }
    
    func updateContent() {
        controller?.updateView()
    }
    
    lazy var showReposWith: ((Model?) -> Void) = { [weak self] data in
        self?.coordinator?.goToRepos(with: data)
    }
    
    func numberOfItemsBy(section: Int?) -> Int {
        items?.count ?? .zero
    }
    
    func numberOfSections() -> Int {
        numberOfSection
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        var userInfo = items?[indexPath.row]
        userInfo?.action = showReposWith
        return userInfo
    }
}
