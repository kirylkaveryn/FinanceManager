//
//  RSCurrencyViewModelTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import XCTest
@testable import FinanceManager

class RSCurrencyViewModelTests: XCTestCase {

    var viewModel: RSCurrencyViewModel!
    var viewController: RSCollectionViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        
        viewModel = RSCurrencyViewModel()
        viewController = RSCollectionViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel
        viewController.loadViewIfNeeded()
        viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_initDefault() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.viewModel)
        
        XCTAssertEqual(viewModel.preferredCurrencyList.count, 4)
    }
    
    func test_initWithCustomDefaultCurrencyArray() {
        let viewModel = RSCurrencyViewModel(preferredCurrencyList: ["USD"])
        XCTAssertEqual(viewModel.preferredCurrencyList.count, 1)
    }
    
    func test_collectionView() {
        XCTAssertEqual(viewController.collectionView.numberOfSections, 2)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 4)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 1), Locale.commonISOCurrencyCodes.count)
        
        viewModel.currencyList = ["USD", "EUR", "BYN"]
        viewModel.preferredCurrencyList = ["USD"]
        
        viewController.collectionView.reloadData()
        
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 1), 3)
        
    }
    

}
