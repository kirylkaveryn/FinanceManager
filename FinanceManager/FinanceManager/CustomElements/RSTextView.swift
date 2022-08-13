//
//  RSTextView.swift
//  FinanceManager
//
//  Created by Kirill on 6.10.21.
//

import UIKit

class RSTextView: UITextView {
    
    let placeholder = "Start here..."
    let placeholderColor: UIColor = .rsRickBlack.withAlphaComponent(0.2)

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        convigureTextView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        convigureTextView()
    }
    
    private func convigureTextView() {
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        text = placeholder
        textColor = placeholderColor
    }
}
