//
//  RSViewControllerAnimation.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation
import UIKit


class RSAnimations: NSObject {
    
    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    static let animationSwipeLeft: CAAnimation = {
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.subtype = CATransitionSubtype.fromRight
        return animation
    }()
    
    static let animationSwipeRight: CAAnimation = {
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = CATransitionType.reveal
        animation.subtype = CATransitionSubtype.fromLeft
        return animation
    }()

}

