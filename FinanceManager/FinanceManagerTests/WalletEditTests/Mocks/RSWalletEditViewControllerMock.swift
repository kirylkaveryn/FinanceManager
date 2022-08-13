//
//  RSWalletEditViewControllerMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 7.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletEditViewControllerMock: RSWalletEditViewControllerProtocol {
    
    var textField: UITextField!
    var titleLabel = UILabel()
    var deleteButton = UIButton()
    var backButton = UIButton()
    var themeIndex = UIImageView()
    var currencyButton = UIButton()
    var scrollView = UIScrollView()
    
    func updateView() {
        
    }
    func textFieldBecomeFirstResponder() {
        
    }


}
