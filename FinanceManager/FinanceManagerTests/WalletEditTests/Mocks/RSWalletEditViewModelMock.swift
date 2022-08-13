//
//  RSWalletEditViewModelMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import Foundation
@testable import FinanceManager

class RSWalletEditViewModelMock: RSWalletEditViewModelTypeProtocol {

    var coordinator: RSWalletEditCoordinatorProtocol?
    var viewController: RSWalletEditViewControllerProtocol?
    
    var wallet: Wallet?
    var titleLabel = "Edit wallet"
    var currencyLabel = "USD $"
    var currencyCode = "USD"
    var walletName = "Wallet"
    var deleteButtonIsHidden = true
    var themeIndex = 1
    
    var deleteButtonDidPress = false
    var backButtonDidPress = false
    var colorThemeButtonDidPress = false
    var currencyButtonDidPress = false
    var textFieldDidChangeText = false
    var updateWalletDidComplete = false

    
    func deleteButtonPressed() {
        deleteButtonDidPress = true
    }
    
    func backButtonPressed() {
        backButtonDidPress = true
    }
    
    func colorThemeButtonPressed() {
        colorThemeButtonDidPress = true
    }
    
    func currencyButtonPressed() {
        currencyButtonDidPress = true
    }
    
    func textFieldDidChange(title: String) {
        textFieldDidChangeText = true
    }
    
    func updateWallet() {
        updateWalletDidComplete = true
    }
    
}
