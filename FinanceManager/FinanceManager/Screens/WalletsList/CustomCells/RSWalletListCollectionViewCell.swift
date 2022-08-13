//
//  RSWalletListCollectionViewCell.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit

class RSWalletListCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "RSWalletListCollectionViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var lastChangeDate: UILabel!
    @IBOutlet weak var lastChangeTitle: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(walletName: String, sum: String, currencySymbol: String, lastChangeDate: String) {
        self.name.text = walletName
        self.sum.text = sum
        self.currencySymbol.text = currencySymbol
        if lastChangeDate.isEmpty {
            self.lastChangeDate.isHidden = true
            self.lastChangeTitle.isHidden = true
        }
        self.lastChangeDate.text = lastChangeDate
    }

}
