//
//  RSColorThemeViewModelTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSColorThemeViewModelTests: XCTestCase {

    var viewModel: RSColorThemeViewModel!
    var coordinator: RSColorThemeCoordinatorMock!
    var controller: RSCollectionViewControllerMock!
    let images = RSThemeImageViews
    
    override func setUp() {
        super.setUp()
        coordinator = RSColorThemeCoordinatorMock()
        controller = RSCollectionViewControllerMock()
        viewModel = RSColorThemeViewModel(backgroundImages: images, themeIndex: 0)
        
        viewModel.coordinator = coordinator
        viewModel.controller = controller
        controller.viewModel = viewModel
    }

    override func tearDown() {
        viewModel = nil
        coordinator = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(coordinator)
        XCTAssertNotNil(viewModel.coordinator)
        XCTAssertNotNil(viewModel.controller)

        XCTAssertEqual(viewModel.images?.count, images.count)
        XCTAssertEqual(viewModel.themeIndex, 0)
    }

}
