//
//  RSIconDeleteButton.swift
//  FinanceManager
//
//  Created by Kirill on 27.09.21.
//

import UIKit

class RSIconDeleteButton: UIButton {

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tintColor = .rsAmaranthRed
    }
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                tintColor = .rsAmaranthRed
            } else {
                tintColor = .rsGreenBlueCryola
            }
        }
    }

}
