//
//  RSTransactionListCoordinator.swift
//  FinanceManager
//
//  Created by Kirill on 26.09.21.
//

import Foundation

import Foundation
import UIKit

class RSTransactionListCoordinator: CoordinatorProtocol, CoreDataProtocol {
    
    var coreDataManager: CoreDataManageProtocol
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    private var wallet: Wallet
    private var viewController: RSCollectionViewController?
    private var viewModel: RSTransactionListViewModel?
    var transactionDetailCoordinator: RSTransactionDetailCoordinator?
    
    var coordinatorDidResign: (() -> ())?
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, wallet: Wallet) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.wallet = wallet
    }
    
    func start() {
        let viewController = RSCollectionViewController(nibName: nil, bundle: nil)
        let viewModel = RSTransactionListViewModel(wallet: wallet)
        
        viewController.viewModel = viewModel
        viewModel.coordinator = self

        self.viewController = viewController
        self.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.view.layer.add(RSAnimations.animationSwipeLeft, forKey: nil)
    }

}


extension RSTransactionListCoordinator: RSTransactionListViewControllerCoordinatorDelegate {
    func backButtonDidPress() {
        navigationController.popViewController(animated: true)
        coordinatorDidResign?()
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
