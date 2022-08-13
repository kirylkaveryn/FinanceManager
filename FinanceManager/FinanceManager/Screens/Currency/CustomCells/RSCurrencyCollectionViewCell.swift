//
//  RSColorThemeCell.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import UIKit

class RSCurrencyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    static let reuseID = "RSCurrencyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
