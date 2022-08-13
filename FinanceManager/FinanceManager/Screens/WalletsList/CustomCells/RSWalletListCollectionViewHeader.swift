//
//  RSWalletListCollectionViewHeader.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit

class RSWalletListCollectionViewHeader: UICollectionReusableView {
    
    static let reuseID = "RSWalletListCollectionViewHeader"
    static let kind = "RSWalletListCollectionViewHeader"
    
    var delegate: RSWalletListCoordinatorProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func newWalletButtonPressed(_ sender: Any) {
        delegate?.walletListDidSelectNewWallet()
    }
    

}
