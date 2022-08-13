//
//  RSColorThemeCell.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import UIKit

class RSColorThemeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseID = "RSColorThemeCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
}
