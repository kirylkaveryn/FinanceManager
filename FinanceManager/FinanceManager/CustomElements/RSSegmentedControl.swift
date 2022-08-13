//
//  RSSegmentedControl.swift
//  FinanceManager
//
//  Created by Kirill on 28.09.21.
//

import UIKit

enum SegmentControlState {
    case outcome
    case income
}

class RSSegmentedControl: UISegmentedControl {
    
    var segmentControlState: SegmentControlState = .outcome
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSegmentedControl()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSegmentedControl()
    }
    
    func configureSegmentedControl() {
        configureGradientLayer()
        colorizeSegmentControl()
        addTarget(self, action: #selector(colorizeSegmentControl), for: .primaryActionTriggered)
    }
    
    @objc private func colorizeSegmentControl() {
        if selectedSegmentIndex == 1 {
            setTitleTextAttributes([.font : UIFont.rsMedium13!, .foregroundColor : UIColor.rsAmaranthRed], for: .normal)
            setTitleTextAttributes([.font : UIFont.rsMedium13!, .foregroundColor : UIColor.rsCeladon], for: .selected)
        } else {
            setTitleTextAttributes([.font : UIFont.rsMedium13!, .foregroundColor : UIColor.rsCeladon], for: .normal)
            setTitleTextAttributes([.font : UIFont.rsMedium13!, .foregroundColor : UIColor.rsAmaranthRed], for: .selected)
        }
    }
    
    @objc func changeState() {
        if selectedSegmentIndex == 0 {
            segmentControlState = .outcome
        } else {
            segmentControlState = .income
        }
    }
    
    func changeStateTo(state: SegmentControlState) {
        segmentControlState = state
        switch state {
        case .outcome:
            selectedSegmentIndex = 0
        case .income:
            selectedSegmentIndex = 1
        }
        colorizeSegmentControl()
    }
}
