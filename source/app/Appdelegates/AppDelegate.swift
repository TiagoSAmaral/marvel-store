//
//  AppDelegate.swift
//  ios-base-project
//
//  Created by Tiago Amaral on 23/01/20.
//  Copyright © 2020 Tiago Amaral. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		self.window =  UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = MainScreenView()
		self.window?.makeKeyAndVisible()
        return true
    }
}

