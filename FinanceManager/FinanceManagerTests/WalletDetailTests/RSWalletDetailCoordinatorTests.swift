//
//  RSWalletDetailCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletDetailCoordinatorTests: XCTestCase {

    var coordinator: RSWalletDetailCoordinator!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationController: UINavigationController!
    var wallet: Wallet!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        guard let wallet = coreDataManagerMock.fetchData().first else { return }
        self.wallet = wallet
        
        coordinator = RSWalletDetailCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, wallet: wallet)
        coordinator.start()
    }

    override func tearDown() {
        coordinator = nil
        coreDataManagerMock = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertNotNil(coordinator.viewModel)
        XCTAssertNotNil(coordinator.viewController?.viewModel)
        XCTAssertNotNil(coordinator.wallet)
    }
    
    func test_walletEditButtonDidPress() {
        XCTAssertNil(coordinator.walletEditCoordinator)
        coordinator.walletEditButtonDidPress()
        XCTAssertNotNil(coordinator.walletEditCoordinator)
    }
    
    func test_walletListButtonDidPress() {
        coordinator.coordinatorDidResign = { [weak self] in
            self?.coordinator = nil
        }
        coordinator.walletListButtonDidPress()
        XCTAssertNil(coordinator)
    }
    
    func test_seeAllTransationsButtonDidPress() {
        XCTAssertNil(coordinator.allTransactionsCoordinator)
        coordinator.seeAllTransationsButtonDidPress()
        XCTAssertNotNil(coordinator.allTransactionsCoordinator)
    }
    
    func test_addTransactionButtonDidPress() {
        XCTAssertNil(coordinator.transactionEditCoordinator)
        coordinator.addTransactionButtonDidPress()
        XCTAssertNotNil(coordinator.transactionEditCoordinator)
    }
    
    
    func test_transactionDidSelect() {
        
        XCTAssertNil(coordinator.transactionDetailCoordinator)
        coreDataManagerMock.createNewTransaction(forWallet: self.wallet, name: "tr1", value: 10, date: Date(), note: "note")
        
        guard let transaction = wallet.transactions?.firstObject as? Transaction else {
            XCTFail("The transacion was not created")
            return
        }
        coordinator.transactionDidSelect(transaction: transaction)
        XCTAssertNotNil(coordinator.transactionDetailCoordinator)
    }

}
