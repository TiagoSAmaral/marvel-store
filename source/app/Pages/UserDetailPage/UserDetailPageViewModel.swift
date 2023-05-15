//
//  PageViewModel.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol UserDetailVM: AnyObject {
    var controller: UserDetailController? { get }
    
    func viewDidAppear()
}

class UserDetailPageViewModel: UserDetailVM, ListDataHandler {
    
    weak var controller: UserDetailController?
    var userDetailNetwork: UserDetailNetwork?
    var coordinator: UserDetailCoordinable?
    var dataToSearch: Model?
    var userInfo: Model?
    
    init(controller: UserDetailController? = nil) {
        self.controller = controller
    }
    
    func viewDidAppear() {
        
        requestUserInfo()
    }
    
    func requestUserInfo() {
        guard let dataToSearch = dataToSearch as? UserInfoListItem else {
            return
        }
        
        userDetailNetwork?.requestUser(with: dataToSearch.login, handler: {[weak self] result in
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let userInfo):
                    self?.userInfo = userInfo
                    self?.updateContent()
                case .failure(let error):
                    debugPrint(error.message)
                }
            }
        })
    }
    
    func updateContent() {
        controller?.updateView()
    }
    
    lazy var showReposWith: ((Model?) -> Void) = { [weak self] model in
        self?.coordinator?.goToRepos(with: model)
    }
    
    func numberOfItemsBy(section: Int?) -> Int {
        1
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func dataBy(indexPath: IndexPath) -> Model? {
        userInfo?.action = showReposWith
        
        return userInfo
    }
    
}
