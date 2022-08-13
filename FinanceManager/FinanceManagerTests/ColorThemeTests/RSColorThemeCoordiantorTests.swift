//
//  RSColorThemeCoordinatorTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import XCTest
@testable import FinanceManager

class RSColorThemeCoordinatorTests: XCTestCase {

    var coordinator: RSColorThemeCoordinator!

    override func setUpWithError() throws {
        super.setUp()
        
        coordinator = RSColorThemeCoordinator(navigationController: UINavigationController(), themeIndex: 0)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        
        super.tearDown()
    }
    
    func test_coordinatorStart() {
        XCTAssertNotNil(coordinator)
        coordinator.start()

    }
    
    func test_backButtonDidPress() {
        var coordinatorDidResignClosureCounter = 0
        coordinator.coordinatorDidResign? = {
            coordinatorDidResignClosureCounter += 1
            XCTAssertTrue(coordinatorDidResignClosureCounter == 1)
        }
        coordinator.backButtonDidPress()

    }
    
    func test_colorThemeCellDidSelect() {
        
        coordinator.colorThemeDidSet? = { themeIndex in
            XCTAssertEqual(themeIndex, 1)
        }
        coordinator.colorThemeCellDidSelect(themeIndex: 1)
    }

}
