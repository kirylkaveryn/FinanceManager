//
//  RSWalletEditCoordiantor.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

enum WalletEditMode {
    case new
    case edit(Wallet)
}

class RSWalletEditCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var coreDataManager: CoreDataManageProtocol
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    var wallet: Wallet?
    var viewController: RSWalletEditViewController?
    var viewModel: RSWalletEditViewModel?
    
    var colorThemeCoordinator: RSColorThemeCoordinator?
    var currencyCoordinator: RSCurrencyCoordinator?
    var walletEditMode: WalletEditMode
    
    var deleteButtonDidPress: (() -> ())?
    var backButtonDidPress: (() -> ())?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, walletEditMode: WalletEditMode) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        switch walletEditMode {
        case .new:
            self.wallet = nil
            self.walletEditMode = .new
        case .edit(let wallet):
            self.wallet = wallet
            self.walletEditMode = .edit(wallet)
        }
    }
    
    func start() {
        let viewController = RSWalletEditViewController(nibName: nil, bundle: nil)
        let viewModel = RSWalletEditViewModel(navigationController: navigationController, coreDataManager: coreDataManager, walletEditMode: walletEditMode)
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
        self.viewController = viewController
        self.viewModel = viewModel
    }
}

extension RSWalletEditCoordinator: RSWalletEditCoordinatorProtocol {
    func deleteButtonPressed() {
        self.navigationController.popToRootViewController(animated: false)
        self.deleteButtonDidPress?()
    }
    
    func backButtonPressed() {
        self.navigationController.popViewController(animated: false)
        self.backButtonDidPress?()
    }
    
    func colorThemeButtonPressed() {
        let colorThemeCoordinator = RSColorThemeCoordinator(navigationController: navigationController, themeIndex: wallet?.themeIndex)
        colorThemeCoordinator.colorThemeDidSet = { [weak self] themeIndex in
            guard let self = self else { return }
            self.viewModel?.updateWalletThemeImage(themeIndex: themeIndex)
        }
        colorThemeCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.colorThemeCoordinator = nil
        }
        
        colorThemeCoordinator.start()
        self.colorThemeCoordinator = colorThemeCoordinator
    }
    
    func currencyButtonPressed() {
        let currencyCoordinator = RSCurrencyCoordinator(navigationController: navigationController)
        currencyCoordinator.currencyDidSet = { [weak self] currency in
            guard let self = self else { return }
            guard let currency = currency else { return }
            self.viewModel?.updateWalletCurrency(currency: currency)
        }
        currencyCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.currencyCoordinator = nil
        }
        
        currencyCoordinator.start()
        
        self.currencyCoordinator = currencyCoordinator
    }
}
