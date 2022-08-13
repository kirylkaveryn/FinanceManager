//
//  RSWalletListCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit


class RSWalletListCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var coreDataManager: CoreDataManageProtocol
    weak var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    private var walletList: [Wallet]
    private var walletListViewController: RSCollectionViewController?
    private var walletListViewModel: RSWalletListViewModel?
    
    private var walletNewCoordinator: RSWalletEditCoordinator?
    private var walletDetailCoordinator: RSWalletDetailCoordinator?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, walletList: [Wallet]) {
        self.navigationController = navigationController
        self.walletList = walletList
        self.coreDataManager = coreDataManager
    }
    
    func start() {
        let walletListViewController = RSCollectionViewController(nibName: nil, bundle: nil)
        let walletListViewModel = RSWalletListViewModel(walletList: walletList, coreDataManager: coreDataManager)
        
        walletListViewController.viewModel = walletListViewModel
        walletListViewModel.coordinator = self

        self.walletListViewController = walletListViewController
        self.walletListViewModel = walletListViewModel
        
        walletListViewController.loadViewIfNeeded()
        navigationController.pushViewController(walletListViewController, animated: false)
        
        if let currentWallet = UserDefaults.standard.value(forKey: rsDefaultsCurrentWallet) as? Int {
            walletListDidSelectWallet(atIndex: currentWallet)
        }
    }

}


extension RSWalletListCoordinator: RSWalletListCoordinatorProtocol {

    func walletListDidSelectWallet(atIndex index: Int) {
        let walletDetailCoordinator = RSWalletDetailCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, wallet: walletList[index])
        walletDetailCoordinator.parentCoordinator = self
        
        walletDetailCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.walletList = self.coreDataManager.fetchData()
            self.walletListViewModel?.updateCollectionView(walletList: self.walletList)
            self.walletDetailCoordinator = nil
            UserDefaults.standard.set(nil, forKey: rsDefaultsCurrentWallet)
        }
        
        UserDefaults.standard.set(index, forKey: rsDefaultsCurrentWallet)

        walletDetailCoordinator.start()
        self.walletDetailCoordinator = walletDetailCoordinator
    
    }
    
    func walletListDidSelectNewWallet() {
        let walletNewCoordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, walletEditMode: .new)
        walletNewCoordinator.parentCoordinator = self
        
        walletNewCoordinator.backButtonDidPress = { [weak self] in
            guard let self = self else { return }
            self.walletList = self.coreDataManager.fetchData()
            self.walletListViewModel?.updateCollectionView(walletList: self.walletList)
            self.walletNewCoordinator = nil
            UserDefaults.standard.set(nil, forKey: rsDefaultsCurrentWallet)
        }
        
        walletNewCoordinator.start()
        self.walletNewCoordinator = walletNewCoordinator
    }
    
}
