//
//  AppDelegate.swift
//  list-store
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
        
        RealmMigrationHandler.setMigrationVersion()
		self.window = UIWindow(frame: UIScreen.main.bounds)
        RealmInstance.sanitizeRealm()
        self.window?.rootViewController = startApplication()
		self.window?.makeKeyAndVisible()

        return true
    }
    
    private func startApplication() -> UIViewController? {
        MainTabbarFactory.makePage()
    }
}
