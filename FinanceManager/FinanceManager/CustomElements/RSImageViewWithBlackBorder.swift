//
//  RSImageViewWithBlackBorder.swift
//  FinanceManager
//
//  Created by Kirill on 28.09.21.
//

import UIKit

class RSImageViewWithBlackBorder: UIImageView {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
