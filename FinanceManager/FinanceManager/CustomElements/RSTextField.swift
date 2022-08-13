//
//  RSTextField.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import UIKit

class RSTextField: UITextField {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayer()
    }
    
    func configureLayer() {
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }

    
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
