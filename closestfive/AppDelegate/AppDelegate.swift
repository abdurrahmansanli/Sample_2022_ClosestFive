//
//  AppDelegate.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeRootController()
        return true
    }
    
    private func initializeRootController() {
        let rootController = VenuesViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

