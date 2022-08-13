//
//  RSIconButton.swift
//  FinanceManager
//
//  Created by Kirill on 27.09.21.
//

import UIKit

class RSIconButton: UIButton {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        tintColor = .rsGreenBlueCryola
    }
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                tintColor = .rsDeepSaffron
            } else {
                tintColor = .rsGreenBlueCryola
            }
        }
    }
    
}
