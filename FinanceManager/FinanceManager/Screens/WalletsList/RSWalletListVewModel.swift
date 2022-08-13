//
//  RSWalletListVewModel.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import Foundation
import UIKit

protocol RSWalletListCoordinatorProtocol: CoordinatorProtocol {
    func walletListDidSelectWallet(atIndex index: Int)
    func walletListDidSelectNewWallet()
}

class RSWalletListViewModel: NSObject {
    weak var coordinator: RSWalletListCoordinatorProtocol?
    weak var controller: RSCollectionViewControllerProtocol?
    var coreDataManager: CoreDataManageProtocol
    
    private var walletList: [Wallet]
    
    init(walletList: [Wallet], coreDataManager: CoreDataManageProtocol) {
        self.walletList = walletList
        self.coreDataManager = coreDataManager
    }
    
    func updateCollectionView(walletList: [Wallet]) {
        self.walletList = walletList
        controller?.collectionView.reloadData()
    }
}

extension RSWalletListViewModel: RSCollectionViewViewModelTypeProtocol  {
    
    func registerCells() {
        controller?.collectionView.register(UINib(nibName: "RSWalletListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RSWalletListCollectionViewCell.reuseID)
        controller?.collectionView.register(UINib(nibName: "RSWalletListCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RSWalletListCollectionViewHeader.reuseID)
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return walletList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSWalletListCollectionViewCell.reuseID, for: indexPath) as! RSWalletListCollectionViewCell
        let wallet = walletList[indexPath.item]
        cell.name.text = wallet.name
        
        let name = wallet.name
        var sum: Float = 0
        let currencySymbol = currencySymbolByCode(code: wallet.currency)
        var lastChangeDate = ""
        // check if transactions are not nil
        if let transactions = wallet.transactions {
            if transactions.count == 0 {
                cell.lastChangeDate.text = dateGetCurrentDateString()
                sum = 0
            } else {
                // calculate the result sum of all transactions
                wallet.transactions.map({ transactions in
                    for case let transaction as Transaction in transactions {
                        sum += Float(truncating: transaction.value)
                    }
                })
                let firstObject = transactions.firstObject as? Transaction
                lastChangeDate = dateGetFullDateString(date: firstObject!.date)
            }
        }
        cell.configureView(walletName: name, sum: sum.description, currencySymbol: currencySymbol, lastChangeDate: lastChangeDate)
        
        return cell
    }
    
    // MARK: - CollectionView LayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 34, height: 208)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RSWalletListCollectionViewHeader.reuseID, for: indexPath) as! RSWalletListCollectionViewHeader
            header.delegate = coordinator
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
        coordinator?.walletListDidSelectWallet(atIndex: indexPath.item)
    }
    
    // MARK: - Actions fot buttons
    @objc func newWalletButtonPressed() {
        coordinator?.walletListDidSelectNewWallet()
    }
}
