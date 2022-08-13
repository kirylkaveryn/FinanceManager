//
//  RSWalletDetailViewControllerTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletDetailViewControllerTests: XCTestCase {
    
    var viewController: RSWalletDetailViewController!
    
    var viewModelMock: RSWalletDetailViewModelMock!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationControllerMock: UINavigationController!
    
    override func setUpWithError() throws {
        super.setUp()
        
        viewController = RSWalletDetailViewController(nibName: nil, bundle: nil)
        
        
        navigationControllerMock = UINavigationController()
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        guard let wallet = coreDataManagerMock.fetchData().first else { return }

        viewModelMock = RSWalletDetailViewModelMock(wallet: wallet, coreDataManager: coreDataManagerMock)
        
        viewController.viewModel = viewModelMock
        viewController.loadViewIfNeeded()
        viewController.viewDidLoad()
        viewController.viewWillAppear(true)
    }

    override func tearDownWithError() throws {
        viewController = nil
        viewModelMock = nil
        coreDataManagerMock = nil
        navigationControllerMock = nil
        super.tearDown()
    }

    func test_init() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.viewModel)
    }

    func test_updateView() {
        viewModelMock.walletName = "newWalletName"
        viewModelMock.walletTransactionsSum = "100"
        
        XCTAssertEqual(viewController.walletName.text, viewModelMock.walletName)
        
        viewController.updateView()
        
        XCTAssertEqual(viewController.walletName.text, viewModelMock.walletName)
        XCTAssertEqual(viewController.walletSum.text, viewModelMock.walletTransactionsSum)
    }

    
    func test_walletListButtonDidPress() {
        XCTAssertFalse(viewModelMock.walletListButtonPressed)
        viewController.walletListButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.walletListButtonPressed)
    }
    func test_walletEditButtonDidPress() {
        XCTAssertFalse(viewModelMock.walletEditButtonPressed)
        viewController.walletEditButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.walletEditButtonPressed)
    }
    
    func test_seeAllButtonDidPress() {
        XCTAssertFalse(viewModelMock.seeAllTransationsButtonPressed)
        viewController.seeAllButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.seeAllTransationsButtonPressed)
    }
    
    func test_addTransactionButtonDidPress() {
        XCTAssertFalse(viewModelMock.addTransactionButtonPressed)
        viewController.addTransactionButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.addTransactionButtonPressed)
    }
}


