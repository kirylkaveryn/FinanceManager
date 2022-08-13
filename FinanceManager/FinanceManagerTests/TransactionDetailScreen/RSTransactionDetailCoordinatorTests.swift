//
//  RSTransactionDetailCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSTransactionDetailCoordinatorTests: XCTestCase {

    var coordinator: RSTransactionDetailCoordinator!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationController: UINavigationController!
    var transaction: Transaction!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
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
        
        coordinator = RSTransactionDetailCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, transaction: transaction)
        coordinator.start()
    }

    override func tearDown() {
        coordinator = nil
        coreDataManagerMock = nil
        navigationController = nil
        transaction = nil
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertNotNil(coordinator.viewModel)
        XCTAssertNotNil(coordinator.viewController?.viewModel)
        XCTAssertNotNil(coordinator.transaction)
    }

    func test_transactionEditButtonDidPress() {
        XCTAssertNil(coordinator.transactionEditCoordinator)
        coordinator.transactionEditButtonDidPress()
        XCTAssertNotNil(coordinator.transactionEditCoordinator)
    }

    func test_backButtonDidPress() {
        coordinator.coordinatorDidResign = { [weak self] in
            self?.coordinator = nil
        }
        coordinator.backButtonDidPress()
        XCTAssertNil(coordinator)
    }

}
