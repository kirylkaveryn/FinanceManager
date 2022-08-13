//
//  RSWalletDetailViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 26.09.21.
//

import Foundation
import UIKit

protocol RSWalletDetailCoordinatorProtocol: CoordinatorProtocol {
    func walletEditButtonDidPress()
    func walletListButtonDidPress()
    func seeAllTransationsButtonDidPress()
    func addTransactionButtonDidPress()
    func transactionDidSelect(transaction: Transaction)
}

protocol RSWalletDetailViewControllerProtocol: AnyObject {
    var collectionView: UICollectionView! { get set }
    func updateView()
}

protocol RSWalletDetailViewModelType: AnyObject {
    var coordinator: RSWalletDetailCoordinator? { get set }
    var controller: RSWalletDetailViewControllerProtocol? { get set }
    var wallet: Wallet { get set }
}

class RSWalletDetailViewModel: NSObject, RSWalletDetailViewModelType {
    weak var controller: RSWalletDetailViewControllerProtocol?
    var coordinator: RSWalletDetailCoordinator?
    var coreDataManager: CoreDataManageProtocol
    
    var wallet: Wallet
    var walletName: String?
    var walletTransactionsSum: String?
    
    var sortedTransactions: [Transaction] = []
    
    init(wallet: Wallet, coreDataManager: CoreDataManageProtocol) {
        self.wallet = wallet
        self.coreDataManager = coreDataManager
        super.init()
        updateView(wallet: wallet)
    }
    
    func updateView(wallet: Wallet) {
        self.wallet = wallet
        self.walletName = wallet.name
        self.walletTransactionsSum = wallet.transactions.map({ transactions in
            var sum: Float = 0
            for case let transaction as Transaction in transactions {
                if transaction.value != NSDecimalNumber.notANumber && transaction.value != 0 {
                    sum += Float(truncating: transaction.value)
                }
            }
            return sum.description + " " + currencySymbolByCode(code: wallet.currency)
        })
        // create Sorted by Date Array of Transactions
        if let transactions = wallet.transactions {
            if let sortedSet = (transactions.array as? [Transaction])?.sorted(by: { tr1, tr2 in
                return tr1.date > tr2.date
            }) {
                sortedTransactions = sortedSet
            }
        }
        self.controller?.updateView()
    }
    
    func walletEditButtonDidPress() {
        coordinator?.walletEditButtonDidPress()
    }
    
    func walletListButtonDidPress() {
        coordinator?.walletListButtonDidPress()
    }
    
    func seeAllTransationsButtonDidPress() {
        coordinator?.seeAllTransationsButtonDidPress()
    }
    
    func addTransactionButtonDidPress() {
        coordinator?.addTransactionButtonDidPress()
    }

}

extension RSWalletDetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func registerCells() {
        controller?.collectionView.register(UINib(nibName: "RSTransactionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RSTransactionCollectionViewCell.reuseID)
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let transactions = wallet.transactions else { return 0 }
        if transactions.count == 0 {
            return 0
        } else {
            let maxCellNumber = Int((controller?.collectionView.frame.height)! / 90)
            return min(maxCellNumber, transactions.count)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSTransactionCollectionViewCell.reuseID, for: indexPath) as! RSTransactionCollectionViewCell
        
        let transaction = sortedTransactions[indexPath.item]
        cell.configureCell(name: transaction.name,
                           value: transaction.value,
                           date: transaction.date,
                           currency: wallet.currency)
        return cell
    }
    
    // MARK: - CollectionView LayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (controller?.collectionView.frame.width)!, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let transaction = wallet.transactions?.first(where: {$0 as? Transaction == sortedTransactions[indexPath.item]}) as? Transaction else { return }
        coordinator?.transactionDidSelect(transaction: transaction)
    }
    
}
