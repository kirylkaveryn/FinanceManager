//
//  RSTransactionEditCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

enum TransactionEditMode {
    case new
    case edit(Transaction)
}

class RSTransactionEditCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var coreDataManager: CoreDataManageProtocol
    var navigationController: UINavigationController
    
    var wallet: Wallet
    var transactionEditMode: TransactionEditMode
    
    var saveTransaction: (() -> ())?
    var deleteButtonDidPress: (() -> ())?
    var coordinatorDidResign: (() -> ())?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, wallet: Wallet, transactionControllerStyle: TransactionEditMode) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.wallet = wallet
        switch transactionControllerStyle {
        case .new:
            self.transactionEditMode = .new
        case .edit(let transaction):
            self.transactionEditMode = .edit(transaction)
        }
    }
    
    func start() {
        let viewController = RSTransactionEditViewController(nibName: nil, bundle: nil)
        let viewModel = RSTransactionEditViewModel(navigationController: navigationController, coreDataManager: coreDataManager, wallet: wallet, transactionEditMode: transactionEditMode)
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RSTransactionEditCoordinator: RSTransactionEditCoordinatorProtocol {
    func backButtonPressed() {
        navigationController.popViewController(animated: false)
        coordinatorDidResign?()
    }
    
}
