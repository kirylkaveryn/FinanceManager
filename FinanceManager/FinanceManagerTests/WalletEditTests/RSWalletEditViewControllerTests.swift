//
//  RSWalletEditViewControllerTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletEditViewControllerTests: XCTestCase {

    var viewController: RSWalletEditViewController!
    var viewModelMock: RSWalletEditViewModelMock!

    override func setUpWithError() throws {
        super.setUp()
        
        viewController = RSWalletEditViewController(nibName: "RSWalletEditViewController", bundle: nil)
        viewModelMock = RSWalletEditViewModelMock()
        viewController.viewModel = viewModelMock
        viewController.loadViewIfNeeded()
        viewController.viewDidLoad()
        viewController.viewWillAppear(true)

    }

    override func tearDownWithError() throws {
        viewController = nil
        viewModelMock = nil
        
        super.tearDown()
    }
    
    func test_viewControllerFields() {
        XCTAssertEqual(viewController.titleLabel.text, viewModelMock.titleLabel)
        XCTAssertEqual(viewController.currencyButton.titleLabel?.text, viewModelMock.currencyLabel)
        XCTAssertEqual(viewController.textField.text, viewModelMock.walletName)
        XCTAssertEqual(viewController.deleteButton.isHidden, true)
    }
    
    func test_viewControllerButtonsActions() {
        XCTAssertFalse(viewModelMock.backButtonDidPress)
        viewController.backButtonPressed()
        XCTAssertTrue(viewModelMock.backButtonDidPress)
        
        XCTAssertFalse(viewModelMock.colorThemeButtonDidPress)
        viewController.colorThemeButtonPressed()
        XCTAssertTrue(viewModelMock.colorThemeButtonDidPress)
        
        XCTAssertFalse(viewModelMock.currencyButtonDidPress)
        viewController.currencyButtonPressed()
        XCTAssertTrue(viewModelMock.currencyButtonDidPress)
        
        XCTAssertFalse(viewModelMock.textFieldDidChangeText)
        viewController.textFieldDidChange(self)
        XCTAssertTrue(viewModelMock.textFieldDidChangeText)
        
    }

}


