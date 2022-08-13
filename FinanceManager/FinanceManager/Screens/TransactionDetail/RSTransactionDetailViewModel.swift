//
//  RSTransactionDetailViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 29.09.21.
//

import Foundation
import UIKit


protocol RSTransactionDetailCoordinatorProtocol: CoordinatorProtocol {
    func transactionEditButtonDidPress()
    func backButtonDidPress()
}

protocol RSTransactionDetailViewControllerProtocol: AnyObject {
    func updateView()
}

protocol RSTransactionDetailViewModelType: AnyObject {
    var coordinator: RSTransactionDetailCoordinatorProtocol? { get set }
    var controller: RSTransactionDetailViewControllerProtocol? { get set }
    var navigationController: UINavigationController { get set }
    var coreDataManager: CoreDataManageProtocol { get set }
    
    var transaction: Transaction { get set }
    var transactionState: SegmentControlState { get set }
    var date: String  { get set }
    var name: String { get set }
    var value: String { get set }
    var note: String? { get set }
    var currency: String { get set }
    
    func updateView()
    func transactionEditButtonDidPress()
    func backButtonDidPress()
    func transactionDeleteButtonDidPress()
}

class RSTransactionDetailViewModel: NSObject, RSTransactionDetailViewModelType {
    weak var coordinator: RSTransactionDetailCoordinatorProtocol?
    weak var controller: RSTransactionDetailViewControllerProtocol?
    var navigationController: UINavigationController
    var coreDataManager: CoreDataManageProtocol
    
    var transaction: Transaction
    var date: String
    var name: String
    var value: String
    var note: String?
    var currency: String
    var transactionState: SegmentControlState
    
    init(navigationController: UINavigationController, coreDataManager: CoreDataManageProtocol, transaction: Transaction, currency: String) {
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
        self.transaction = transaction
        self.currency = currency
        self.name = transaction.name
        self.note = transaction.note
        self.date = dateGetFullDateString(date: transaction.date)
        self.transactionState = transaction.value.intValue > 0 ? .income : .outcome
        self.value = {
            let prefix = transaction.value.intValue > 0 ? "+" : ""
            return prefix + transaction.value.description + currencySymbolByCode(code: currency)
        }()
    }
    
    func updateView() {
        name = transaction.name
        note = transaction.note
        date = dateGetFullDateString(date: transaction.date)
        transactionState = transaction.value.intValue > 0 ? .income : .outcome
        value = {
            let prefix = transaction.value.intValue > 0 ? "+" : ""
            return prefix + transaction.value.description + currencySymbolByCode(code: currency)
        }()
        controller?.updateView()
    }

    func transactionEditButtonDidPress() {
        coordinator?.transactionEditButtonDidPress()
    }
    
    func backButtonDidPress() {
        coordinator?.backButtonDidPress()
    }
    
    func transactionDeleteButtonDidPress() {
        let alert = UIAlertController(title: "Delete transaction?", message: nil, preferredStyle: .alert)
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.coreDataManager.deleteTransaction(fromWallet: self.transaction.wallet, transaction: self.transaction)
            self.backButtonDidPress()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(delete)
        alert.addAction(cancelAction)
        navigationController.present(alert, animated: true) {
            alert.removeFromParent()
        }
    }
}
