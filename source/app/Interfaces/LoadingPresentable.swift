//
//  LoadingManager.swift
//  github-person
//
//  Created by Tiago Amaral on 16/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol LoadingPresentable where Self: UIViewController {
    
    var loadingController: LoadingViewController? { get set }
    func startLoading()
    func stopLoading()
}

extension LoadingPresentable {
    
    func startLoading() {
        loadingController = LoadingViewController()
        loadingController?.modalPresentationStyle = .overCurrentContext
        loadingController?.modalTransitionStyle = .crossDissolve
        if let loadingController = loadingController {
            present(loadingController, animated: true, completion: nil)
        }
    }
    
    func stopLoading() {
        guard let loadingController = loadingController else {
            return
        }
        
        loadingController.dismiss(animated: true) {
            self.loadingController = nil
        }
    }
}
