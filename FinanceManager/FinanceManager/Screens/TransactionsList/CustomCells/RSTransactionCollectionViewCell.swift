//
//  RSTransactionCollectionViewCell.swift
//  FinanceManager
//
//  Created by Kirill on 22.09.21.
//

import UIKit

class RSTransactionCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "RSTransactionCollectionViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String, value: NSDecimalNumber, date: Date, currency: String) {
        self.name.text = name
        self.date.text = dateGetShortDateString(date: date)
        if value.intValue > 0 {
            self.value.textColor = .rsCeladon
            self.value.text = "+" + value.description + (currencySymbolByCode(code:currency))
            self.image.image = UIImage(systemName: "square.and.arrow.down")
        } else {
            self.value.textColor = .rsAmaranthRed
            self.value.text = value.description + (currencySymbolByCode(code:currency))
            self.image.image = UIImage(systemName: "square.and.arrow.up")
        }
    }

}
