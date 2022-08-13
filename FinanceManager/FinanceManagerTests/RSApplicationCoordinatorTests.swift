//
//  RSApplicationCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 7.10.21.
//

import XCTest
import CoreData
@testable import FinanceManager

class RSApplicationCoordinatorTests: XCTestCase {

    var coordinator: RSApplicationCoordinator!
    var coreDataManagerMock: CoreDataManagerMock!
    
    override func setUp() {
        super.setUp()
        
        coreDataManagerMock = CoreDataManagerMock(containerName: "FinanceManager")
        coordinator = RSApplicationCoordinator(window: UIWindow())
        coordinator.coreDataManager = coreDataManagerMock
        
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        coreDataManagerMock.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        
        coordinator.start()
        
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    func test_initializationAndStart() {
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(coordinator.walletListCoordinator)
        
    }
    
    func test_walletListIsCorrect() {
        XCTAssertEqual(coordinator.walletStorage.count, 2)
    }
    
    func test_loadBackgroundImage() {
        coordinator.backgroundThemeIndex = 0
        coordinator.loadBackgroundImage()
        XCTAssertEqual(RSApplicationCoordinator.backgroundImageView.image, RSThemeImageViews[0])
    }

}
