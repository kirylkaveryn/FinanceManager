//
//  RSTransactionDetailViewControllerTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSTransactionDetailViewControllerTests: XCTestCase {
    
    var viewController: RSTransactionDetailViewController!
    
    var viewModelMock: RSTransactionDetailViewModelMock!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationControllerMock: UINavigationController!
    var transacrion: Transaction!
    
    override func setUpWithError() throws {
        super.setUp()
        
        viewController = RSTransactionDetailViewController(nibName: nil, bundle: nil)
        
        
        navigationControllerMock = UINavigationController()
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        guard let wallet = coreDataManagerMock.fetchData().first else { return }
        coreDataManagerMock.createNewTransaction(forWallet: wallet,
                                                 name: "tr1", value: 10,
                                                 date: Date(),
                                                 note: "note")
        guard let transaction = wallet.transactions?.firstObject as? Transaction else { return }
        self.transacrion = transaction
        
        viewModelMock = RSTransactionDetailViewModelMock(navigationController: navigationControllerMock, coreDataManager: coreDataManagerMock, transaction: transaction, currency: wallet.currency)
        
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
        viewModelMock.name = "name"
        viewModelMock.date = dateGetShortDateString(date: Date(timeIntervalSince1970: 0))
        viewModelMock.value = "20"
        viewModelMock.transactionState = .income
        viewModelMock.note = "note"
        
        viewController.updateView()
        
        XCTAssertEqual(viewController.name.text, viewModelMock.name)
        XCTAssertEqual(viewController.value.text, viewModelMock.value)
        XCTAssertEqual(viewController.note.text, viewModelMock.note)
        XCTAssertEqual(viewController.value.textColor, UIColor.rsCeladon)
        
    }

    func test_backButtonDidPress() {
        XCTAssertFalse(viewModelMock.backButtonPressed)
        viewController.backButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.backButtonPressed)
    }
    
    func test_editTransactionButtonDidPress() {
        XCTAssertFalse(viewModelMock.transactionEditButtonPressed)
        viewController.editTransactionButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.transactionEditButtonPressed)
    }
    func test_deleteButtonDidPress() {
        XCTAssertFalse(viewModelMock.transactionDeleteButtonPressed)
        viewController.deleteButtonDidPress(UIButton())
        XCTAssertTrue(viewModelMock.transactionDeleteButtonPressed)
    }
    
    

}



