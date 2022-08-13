//
//  RSWalletDetailViewModelMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletDetailViewModelMock: RSWalletDetailViewModel {
    
    var walletEditButtonPressed = false
    var walletListButtonPressed = false
    var seeAllTransationsButtonPressed = false
    var addTransactionButtonPressed = false

    override func walletEditButtonDidPress() {
        walletEditButtonPressed = true
    }
    
    override func walletListButtonDidPress() {
        walletListButtonPressed = true
    }
    
    override func seeAllTransationsButtonDidPress() {
        seeAllTransationsButtonPressed = true
    }
    
    override func addTransactionButtonDidPress() {
        addTransactionButtonPressed = true
    }

}
