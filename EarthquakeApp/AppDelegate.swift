//
//  AppDelegate.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var viewController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = ListPageController()
        self.viewController = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = self.viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

