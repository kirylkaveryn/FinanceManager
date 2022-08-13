//
//  RSWalletEditViewModelTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 7.10.21.
//

import XCTest

@testable import FinanceManager

class RSWalletEditViewModelTests: XCTestCase {
    
    var viewModel: RSWalletEditViewModel!
    var viewController: RSWalletEditViewControllerMock!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationController: UINavigationController!
    var coordinator: RSWalletEditCoordinatorMock!
    
    override func setUp()  {
        super.setUp()
        navigationController = UINavigationController()
        
        coordinator = RSWalletEditCoordinatorMock(navigationController: navigationController)
        
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        guard let wallet = coreDataManagerMock.fetchData().first else { return }
        
        viewModel = RSWalletEditViewModel(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .edit(wallet))
        
        viewModel.coordinator = coordinator

    }

    override func tearDown() {
        viewModel = nil
        viewController = nil
        coreDataManagerMock = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_initViewModel() {
        XCTAssertNotNil(viewModel)
    }
    
    func test_updateViewModelProperties() {
        let newName = "testWallet2"
        viewModel.updateWalletTitle(title: newName)
        XCTAssertEqual(viewModel.walletName, newName)
        
        let newTheme = 2
        viewModel.updateWalletThemeImage(themeIndex: newTheme)
        XCTAssertEqual(viewModel.themeIndex, newTheme)
        
        let newCurency = "EUR"
        viewModel.updateWalletCurrency(currency: newCurency)
        XCTAssertEqual(viewModel.currencyCode, newCurency)
        
    }
    
    func test_updateCurrentWalletWithNewProperties() {
        let newName = "testWallet2"
        viewModel.updateWalletTitle(title: newName)
        
        let newTheme = 2
        viewModel.updateWalletThemeImage(themeIndex: newTheme)
        
        let newCurency = "EUR"
        viewModel.updateWalletCurrency(currency: newCurency)
        
        viewModel.updateWallet()
        coreDataManagerMock.saveContext()
        
        guard let wallet = coreDataManagerMock.fetchData().first else { return }
        
        XCTAssertEqual(wallet.name, newName)
        XCTAssertEqual(wallet.currency, newCurency)
        XCTAssertEqual(Int(wallet.themeIndex), newTheme)
    }
    
    func test_coordinatorActionsTest() {
        
        viewModel.colorThemeButtonPressed()
        XCTAssertTrue(coordinator.colorThemeButtonDidPress)
        
        viewModel.currencyButtonPressed()
        XCTAssertTrue(coordinator.currencyButtonDidPress)
        
    }
    
    func test_textFieldDidChangeWithCorrectWalletName() {
        let newWalletName = "newWallet"
        viewModel.textFieldDidChange(title: newWalletName)
        XCTAssertEqual(viewModel.walletName, newWalletName)
    
    }
    
    func test_textFieldDidChangeWithIncorrectWalletName() {
        let newWalletName = "012345678901234567890"
        viewModel.textFieldDidChange(title: newWalletName)
        XCTAssertEqual(viewModel.walletName, "01234567890123456789")
    
    }

}
