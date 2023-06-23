//
//  Tabbar.swift
//  list-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

final class MainTabbarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        fixBartintColoriOS15()
        defineApperanceText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fixBartintColoriOS15()
        defineApperanceText()
    }
    
    private func fixBartintColoriOS15() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ColorAsset.cardBackgroundColor
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    private func defineApperanceText() {
        tabBar.isTranslucent = false
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorAsset.descriptionColor ?? .gray]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorAsset.titleColor ?? .red]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}
