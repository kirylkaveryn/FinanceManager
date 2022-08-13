//
//  RSCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

class RSApplicationCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    let window: UIWindow
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var coreDataManager: CoreDataManageProtocol
    
    var walletStorage: [Wallet] = []
    var walletListCoordinator: RSWalletListCoordinator?
    
    var backgroundThemeIndex: Int? = {
        if let currentThemeIndex = UserDefaults.standard.value(forKey: rsDefaultsCurrentThemeIndex) as? Int {
            return currentThemeIndex
        } else {
            return RSThemeImageViews.indices.randomElement()
        }
    }()
    
    static var backgroundImageView = RSBackgroundImage()
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.coreDataManager = CoreDataManager(containerName: "FinanceManager")
        self.window.addSubview(RSApplicationCoordinator.backgroundImageView)
    }
    
    func start() {
        navigationController.navigationBar.isHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadBackgroundImage), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveBackgroundImageToUserDefaults), name: UIApplication.willResignActiveNotification, object: nil)
        
        walletStorage = coreDataManager.fetchData()
        
        let walletListCoordinator = RSWalletListCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, walletList: walletStorage)
        
        walletListCoordinator.parentCoordinator = self
        self.walletListCoordinator = walletListCoordinator
        self.walletListCoordinator?.start()
        
    }
    
    @objc func loadBackgroundImage() {
        if let backgroundThemeIndex = self.backgroundThemeIndex {
            RSApplicationCoordinator.backgroundImageView.image =
                RSThemeImageViews[backgroundThemeIndex]
        } else {
            RSApplicationCoordinator.backgroundImageView.image =
                UIImage()
        }
    }
    
    @objc func saveBackgroundImageToUserDefaults() {
        guard let backgroundImage = RSApplicationCoordinator.backgroundImageView.image else { return }
        guard let themeIndex = RSThemeImageViews.firstIndex(of: backgroundImage) else { return }
        UserDefaults.standard.set(themeIndex, forKey: rsDefaultsCurrentThemeIndex)
    }
      
}
