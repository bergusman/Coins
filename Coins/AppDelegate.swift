//
//  AppDelegate.swift
//  Coins
//
//  Created by Vitaly Berg on 8/13/17.
//  Copyright © 2017 Vitaly Berg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    private func showRoot() {
        let mapVC = MapViewController()
        let nc = UINavigationController(rootViewController: mapVC)
        window?.rootViewController = nc
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        showRoot()
        return true
    }
}
