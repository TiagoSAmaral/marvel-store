//
//  NavigationController.swift
//  marvel-store
//
//  Created by Tiago Amaral on 16/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, LoadingPresentable {
    var loadingController: LoadingViewController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationBar.isTranslucent = false
        fixBartintColoriOS15()
    }
    
    private func fixBartintColoriOS15() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
