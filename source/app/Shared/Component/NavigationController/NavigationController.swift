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
        defineApperance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defineApperance()
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

    func defineApperance() {
        navigationBar.isTranslucent = false
        fixBartintColoriOS15()
        defineBackbuttonApperance()
    }
    
    func defineBackbuttonApperance() {
        
//          .titleTextAttributes = [.foregroundColor: ColorAsset.titleColor]
        navigationItem.backButtonTitle = " qqq"
        navigationBar.tintColor = ColorAsset.titleColor
        navigationBar.backItem?.title = " ggg"
        navigationBar.backItem?.backButtonTitle = " sss"
    }
}
