//
//  RSWalletDetailCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 26.09.21.
//

import Foundation
import UIKit

class RSWalletDetailCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var viewController: RSWalletDetailViewController?
    var viewModel: RSWalletDetailViewModel?
    
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var coordinatorDidResign: (() -> ())?
    var coreDataManager: CoreDataManageProtocol
    
    var wallet: Wallet
    var walletEditCoordinator: RSWalletEditCoordinator?
    var transactionListCoordinator: RSTransactionListCoordinator?
    var transactionEditCoordinator: RSTransactionEditCoordinator?
    var transactionDetailCoordinator: RSTransactionDetailCoordinator?
    var allTransactionsCoordinator: RSTransactionListCoordinator?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, wallet: Wallet) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.wallet = wallet
        
        RSApplicationCoordinator.backgroundImageView.changeImage(with: RSThemeImageViews[Int(wallet.themeIndex)])
    }
    
    func start() {
        let viewController = RSWalletDetailViewController(nibName: nil, bundle: nil)
        let viewModel = RSWalletDetailViewModel(wallet: self.wallet, coreDataManager: coreDataManager)
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
        self.viewController = viewController
        self.viewModel = viewModel
    }
}

extension RSWalletDetailCoordinator: RSWalletDetailCoordinatorProtocol {
    func walletEditButtonDidPress() {
        let walletEditCoordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, walletEditMode: .edit(wallet))
        walletEditCoordinator.parentCoordinator = self

        walletEditCoordinator.backButtonDidPress = { [weak self] in
            guard let self = self else { return }
            self.walletEditCoordinator = nil
            self.viewModel?.updateView(wallet: self.wallet)
        }
        walletEditCoordinator.deleteButtonDidPress = { [weak self] in
            guard let self = self else { return }
            self.walletEditCoordinator = nil
            self.coordinatorDidResign?()
        }
        
        walletEditCoordinator.start()
        self.walletEditCoordinator = walletEditCoordinator
        
    }
    
    func walletListButtonDidPress() {
        self.coordinatorDidResign?()
        self.navigationController.popViewController(animated: true)
    }
    
    func seeAllTransationsButtonDidPress() {
        let allTransactionsCoordinator = RSTransactionListCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, wallet: wallet)
        allTransactionsCoordinator.parentCoordinator = self
        
        allTransactionsCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.allTransactionsCoordinator = nil
            self.viewModel?.updateView(wallet: self.wallet)
        }
        
        allTransactionsCoordinator.start()
        self.allTransactionsCoordinator = allTransactionsCoordinator
    }
    
    func addTransactionButtonDidPress() {
        let transactionEditCoordinator = RSTransactionEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, wallet: wallet, transactionControllerStyle: .new)
        transactionEditCoordinator.parentCoordinator = self
        
        transactionEditCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.transactionEditCoordinator = nil
            self.viewModel?.updateView(wallet: self.wallet)
        }
        
        transactionEditCoordinator.start()
        self.transactionEditCoordinator = transactionEditCoordinator
    }
    
    func transactionDidSelect(transaction: Transaction) {
        let transactionDetailCoordinator = RSTransactionDetailCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, transaction: transaction)
        transactionDetailCoordinator.parentCoordinator = self
        
        transactionDetailCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.transactionDetailCoordinator = nil
            self.viewModel?.updateView(wallet: self.wallet)
        }
        
        transactionDetailCoordinator.start()
        self.transactionDetailCoordinator = transactionDetailCoordinator
    }
}
