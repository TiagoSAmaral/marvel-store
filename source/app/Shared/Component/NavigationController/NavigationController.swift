//
//  NavigationController.swift
//  github-person
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
