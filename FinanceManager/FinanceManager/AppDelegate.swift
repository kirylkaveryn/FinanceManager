//
//  AppDelegate.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var backgroundImage: UIImage?
    private var applicationCoordinator: RSApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = RSApplicationCoordinator(window: window)

        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        applicationCoordinator.start()

        return true
    }
    
}

