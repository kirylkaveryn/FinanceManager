//
//  RSBackgroundImage.swift
//  FinanceManager
//
//  Created by Kirill on 29.09.21.
//

import Foundation
import UIKit

class RSBackgroundImage: UIImageView {

    init() {
        super.init(frame: .zero)
        image = UIImage()
        contentMode = .scaleAspectFill
        frame = UIScreen.main.bounds
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeImage(with image: UIImage) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            self?.image = image
        }
    }
}
