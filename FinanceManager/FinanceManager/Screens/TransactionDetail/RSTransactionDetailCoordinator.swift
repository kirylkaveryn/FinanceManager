//
//  RSTransactionDetailCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 29.09.21.
//

import Foundation
import UIKit

class RSTransactionDetailCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var viewController: RSTransactionDetailViewController?
    var viewModel: RSTransactionDetailViewModel?
    
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var coordinatorDidResign: (() -> ())?
    var coreDataManager: CoreDataManageProtocol
    
    var transaction: Transaction
    var transactionEditCoordinator: RSTransactionEditCoordinator?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, transaction: Transaction) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.transaction = transaction
    }
    
    func start() {
        let viewController = RSTransactionDetailViewController(nibName: nil, bundle: nil)
        let viewModel = RSTransactionDetailViewModel(navigationController: navigationController, coreDataManager: coreDataManager, transaction: transaction, currency: transaction.wallet.currency)
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: false)
        self.viewController = viewController
        self.viewModel = viewModel
    }

}

extension RSTransactionDetailCoordinator: RSTransactionDetailCoordinatorProtocol {
    func transactionEditButtonDidPress() {
        let transactionEditCoordinator = RSTransactionEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManager, wallet: transaction.wallet, transactionControllerStyle: .edit(transaction))
        transactionEditCoordinator.parentCoordinator = self
        
        transactionEditCoordinator.coordinatorDidResign = { [weak self] in
            guard let self = self else { return }
            self.transactionEditCoordinator = nil
            self.viewModel?.updateView()
        }
        
        transactionEditCoordinator.start()
        self.transactionEditCoordinator = transactionEditCoordinator
    }
    
    func backButtonDidPress() {
        navigationController.popViewController(animated: true)
        coordinatorDidResign?()
    }
}
