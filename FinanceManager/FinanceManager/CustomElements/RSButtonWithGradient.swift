//
//  RSButtonWithGradient.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import UIKit

class RSButtonWithGradient: UIButton {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureGradientLayer()
        layer.cornerRadius = 17.5
    }
}
