//
//  RSWalletEditCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 7.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletEditCoordinatorTests: XCTestCase {

    var coordinator: RSWalletEditCoordinator!
    var coreDataManagerMock: CoreDataManagerMock!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        super.setUp()
        navigationController = UINavigationController()
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        
    }

    override func tearDownWithError() throws {
        coordinator = nil
        coreDataManagerMock = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_coordinatorNewWalletStart() {
        coordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .new)
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertNotNil(coordinator.viewModel)
        XCTAssertNil(coordinator.wallet)

        switch coordinator.walletEditMode {
        case .new:
            XCTAssert(true)
        case .edit(_):
            XCTAssert(false)
        }
    }
    
    func test_colorThemeButtonPressed() {
        coordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .new)
        coordinator.start()
        XCTAssertNil(coordinator.colorThemeCoordinator)
        coordinator.colorThemeButtonPressed()
        XCTAssertNotNil(coordinator.colorThemeCoordinator)

    }
    
    func test_currencyButtonPressed() {
        coordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .new)
        coordinator.start()
        XCTAssertNil(coordinator.currencyCoordinator)
        coordinator.currencyButtonPressed()
        XCTAssertNotNil(coordinator.currencyCoordinator)

    }
    
    
    func test_coordinatorEditWalletStart() {
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        guard let wallet = coreDataManagerMock.fetchData().first else { return }
        
        coordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .edit(wallet))
        coordinator.start()
        
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertNotNil(coordinator.viewModel)
        XCTAssertNotNil(coordinator.wallet)

        switch coordinator.walletEditMode {
        case .new:
            XCTAssert(false)
        case .edit(_):
            XCTAssert(true)
        }
    }
    
    func test_deleteAndBackButtonsPressed() {
        coordinator = RSWalletEditCoordinator(navigationController: navigationController, coreDataManager: coreDataManagerMock, walletEditMode: .new)
        coordinator.start()
        
        var closureRequestCounter = 0
        
        coordinator.deleteButtonDidPress = {
            closureRequestCounter = 1
        }
        coordinator.deleteButtonPressed()
        XCTAssert(closureRequestCounter == 1)
        closureRequestCounter = 0
        
        coordinator.backButtonDidPress = {
            closureRequestCounter = 1
        }
        coordinator.backButtonPressed()
        XCTAssert(closureRequestCounter == 1)
        

    }
    

}
