//
//  LoadingManagers.swift
//  github-person
//
//  Created by Tiago Amaral on 16/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol LoadingManagers where Self: UIViewController {
    func startLoading()
    func stopLoading(onFinish: (() -> Void)?)
}

extension LoadingManagers {
    func startLoading() {
        (navigationController as? LoadingPresentable)?.startLoading()
    }

    func stopLoading(onFinish: (() -> Void)?) {
        (navigationController as? LoadingPresentable)?.stopLoading(onFinish: onFinish)
    }
}
