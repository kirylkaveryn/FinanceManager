//
//  UIView+Extensions.swift
//  FinanceManager
//
//  Created by Kirill on 29.09.21.
//

import Foundation
import UIKit

extension UIView {
    func configureGradientLayer() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.init(white: 1, alpha: 0.3).cgColor
        frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        clipsToBounds = true
        
        let layerGlass = CAGradientLayer()
        layerGlass.colors = [
          UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.55).cgColor,
          UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.15).cgColor
        ]
        layerGlass.locations = [0, 1]
        layerGlass.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerGlass.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerGlass.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1, b: -1, c: 1.09, d: -2.91, tx: 0.46, ty: 2.45))
        layerGlass.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        layerGlass.position = center
        
        layer.insertSublayer(layerGlass, at: 0)
        
        backgroundColor = .clear
    }
}
