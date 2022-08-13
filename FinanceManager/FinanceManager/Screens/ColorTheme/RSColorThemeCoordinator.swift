//
//  RSColorThemeCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation
import UIKit

class RSColorThemeCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController

    var coreDataManager: CoreDataManager?
    
    var themeIndex: Int16?
    var colorThemeDidSet: ((Int) -> ())?
    var coordinatorDidResign: (() -> ())?

    init(navigationController: UINavigationController, themeIndex: Int16?) {
        self.navigationController = navigationController
        self.themeIndex = themeIndex
    }
    
    func start() {
        let viewController = RSCollectionViewController(nibName: nil, bundle: nil)
        let viewModel = RSColorThemeViewModel(backgroundImages: RSThemeImageViews, themeIndex: themeIndex)
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

extension RSColorThemeCoordinator: RSColorThemeCoordinatorProtocol {
    func backButtonDidPress() {
        navigationController.popViewController(animated: true)
        coordinatorDidResign?()
    }
    
    func colorThemeCellDidSelect(themeIndex: Int) {
        self.themeIndex = Int16(themeIndex)
        colorThemeDidSet?(themeIndex)
    }
}
