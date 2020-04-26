//
//  AppDelegate.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createContext()
        return true
    }
    
    func createContext() {
        let window = UIWindow()
        window.rootViewController = createHomeWithNavigation()
        AppDelegate.window = window
        window.makeKeyAndVisible()
    }
    
    func createHomeWithNavigation() -> UINavigationController {
        let nav = UINavigationController(rootViewController: HomeViewController())
        nav.setNavigationBarHidden(false, animated: false)
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = .systemIndigo
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.navigationBar.shadowImage = nil
        
        return nav
    }
    
    static func getAPIKey() -> String {
        let bundlePath = Bundle.main.path(forResource: "Info", ofType: "plist")
        let config = NSDictionary(contentsOfFile: bundlePath!)
        let apiKey = config!["API-Key"] as! String

        return apiKey
    }
}

