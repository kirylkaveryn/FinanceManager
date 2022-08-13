//
//  RSTransactionDetailViewModelMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSTransactionDetailViewModelMock: RSTransactionDetailViewModel {

    var transactionEditButtonPressed = false
    var backButtonPressed = false
    var transactionDeleteButtonPressed = false
    
    override func transactionEditButtonDidPress() {
        transactionEditButtonPressed = true
    }
    
    override func backButtonDidPress() {
        backButtonPressed = true
    }
    
    override func transactionDeleteButtonDidPress() {
        transactionDeleteButtonPressed = true
    }
}
