//
//  RSCollectionViewHeader.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import UIKit

class RSCollectionViewHeader: UICollectionReusableView {
    
    static let reuseID = "RSCollectionViewHeader"
    static let kind = "RSCollectionViewHeader"

    @IBOutlet weak var title: UILabel!
    
    var backButtonDidPress: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        backButtonDidPress?()
    }
    
}
