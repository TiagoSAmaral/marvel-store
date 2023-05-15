//
//  AppDelegate.swift
//  github-person
//
//  Created on 23/01/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appViewManager: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        appViewManager = startApplication()
        appViewManager.start()
		self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = appViewManager.navigationController
		self.window?.makeKeyAndVisible()

        #if DEBUG
        print("DEBUB")
        #else
        print("RELEASE")
        #endif

        return true
    }
    
    private func startApplication() -> Coordinator {
        let navigation = UINavigationController()
        navigation.navigationBar.isTranslucent = false
        return AppCoordinator(navigation: navigation)
    }
}
