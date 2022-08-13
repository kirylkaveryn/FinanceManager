//
//  RSWalletEditCoordinatorMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 7.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletEditCoordinatorMock: CoordinatorProtocol, RSWalletEditCoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    var deleteButtonDidPress = false
    var backButtonDidPress = false
    var colorThemeButtonDidPress = false
    var currencyButtonDidPress = false

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
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
    



}
