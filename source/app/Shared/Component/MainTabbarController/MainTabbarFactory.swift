//
//  MainTabbarFactory.swift
//  list-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

struct MainTabbarFactory {
    static func makePage() -> UIViewController {
            
        let tabbar = MainTabbarController()
        var viewControllers: [UIViewController] = []
        
        if let storageFlow = MainTabbarFactory.defineStorageFlow() {
            viewControllers.append(storageFlow)
        }
        
        if let favoriteFlow = MainTabbarFactory.defineFavoriteFlow() {
            viewControllers.append(favoriteFlow)
        }
        
        if let cartFlow = MainTabbarFactory.defineCartFlow() {
            viewControllers.append(cartFlow)
        }
        
        tabbar.viewControllers = viewControllers
        
        return tabbar
    }
    
    private static func defineStorageFlow() -> UIViewController? {
        let navigation = NavigationController()
        let coordinator = ListContentPageCoordinator(navigation: navigation)
        guard let controller = ListContentPageFactory.makePage(coordinator: coordinator, model: nil) else {
            return nil
        }
        navigation.tabBarItem.title = LocalizedText.with(tagName: .storeTitle)
        navigation.viewControllers = [controller]
        return navigation
    }
    
    private static func defineFavoriteFlow() -> UIViewController? {
        let navigation = NavigationController()
        let coordinator = ListFavoritePageCoordinator(navigation: navigation)
        guard let controller = ListFavoritePageFactory.makePage(coordinator: coordinator, model: nil) else {
            return nil
        }
        navigation.title = LocalizedText.with(tagName: .favoriteTitle)
        navigation.viewControllers = [controller]
        return navigation
    }
    
    private static func defineCartFlow() -> UIViewController? {
        let navigation = NavigationController()
        let coordinator = CartPageCoordinator(navigation: navigation)
        guard let controller = CartPageFactory.makePage(coordinator: coordinator, model: nil) else {
            return nil
        }
        navigation.title = LocalizedText.with(tagName: .cartTitle)
        navigation.viewControllers = [controller]
        return navigation
    }
}
