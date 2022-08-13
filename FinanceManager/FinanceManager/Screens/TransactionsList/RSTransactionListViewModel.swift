//
//  RSTransactionListViewModel.swift
//  FinanceManager
//
//  Created by Kirill on 26.09.21.
//

import Foundation
import UIKit

protocol RSTransactionListViewControllerCoordinatorDelegate: AnyObject {
    func backButtonDidPress()
    func transactionDidSelect(transaction: Transaction)
    var coordinatorDidResign: (() -> ())? { get set }
}

class RSTransactionListViewModel: NSObject {
    weak var coordinator: RSTransactionListViewControllerCoordinatorDelegate?
    weak var controller: RSCollectionViewControllerProtocol?
    
    var wallet: Wallet
    var sortedTransactions: [Transaction] = []
    
    init(wallet: Wallet) {
        self.wallet = wallet
        super.init()
        updateView(wallet: wallet)
    }
    
    func updateView(wallet: Wallet) {
        if let transactions = wallet.transactions {
            if let sortedSet = (transactions.array as? [Transaction])?.sorted(by: { tr1, tr2 in
                return tr1.date > tr2.date
            }) {
                sortedTransactions = sortedSet
            }
        }
        controller?.collectionView.reloadData()
    }
        
}

extension RSTransactionListViewModel: RSCollectionViewViewModelTypeProtocol  {
    
    func registerCells() {
        controller?.collectionView.register(UINib(nibName: "RSTransactionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RSTransactionCollectionViewCell.reuseID)
        controller?.collectionView.register(UINib(nibName: "RSCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID)
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedTransactions.count
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
        return CGSize(width: UIScreen.main.bounds.width - 34, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: RSCollectionViewHeader.kind, withReuseIdentifier: RSCollectionViewHeader.reuseID, for: indexPath) as! RSCollectionViewHeader
            header.title.text = "Transactions"
            header.backButtonDidPress = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.backButtonDidPress()
            }
            
            return header
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 115)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 17, bottom: 30, right: 17)
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
