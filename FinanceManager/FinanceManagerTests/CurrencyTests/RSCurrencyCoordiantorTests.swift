//
//  RSCurrencyCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import XCTest
@testable import FinanceManager

class RSCurrencyCoordinatorTests: XCTestCase {

    var coordinator: RSCurrencyCoordinator!

    override func setUpWithError() throws {
        super.setUp()
        
        coordinator = RSCurrencyCoordinator(navigationController: UINavigationController())
        coordinator.start()
        
    }

    override func tearDownWithError() throws {
        coordinator = nil
        
        super.tearDown()
    }
    
    func test_coordinatorStart() {
        XCTAssertNotNil(coordinator)
    }
    
    func test_backButtonDidPress() {
        var coordinatorDidResignClosureCounter = 0
        coordinator.coordinatorDidResign? = {
            coordinatorDidResignClosureCounter += 1
            XCTAssertTrue(coordinatorDidResignClosureCounter == 1)
        }
        coordinator.backButtonDidPress()
        
        let currency = "USD"
        XCTAssertNil(coordinator.currency)
        coordinator.updateCurrency(currency: currency)
        XCTAssertEqual(coordinator.currency, currency)

    }

}
