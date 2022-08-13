//
//  RSWalletListCollectionViewCellTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSWalletListCollectionViewCellTests: XCTestCase {

    var cell: RSWalletListCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = UINib(nibName: "RSWalletListCollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as? RSWalletListCollectionViewCell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.name)
        XCTAssertNotNil(cell.currencySymbol)
        XCTAssertNotNil(cell.lastChangeDate)
        XCTAssertNotNil(cell.lastChangeTitle)
    }
    
    func test_configureCell() {
        let name = "Wallet"
        let sum = "10"
        let currencySymbol = "$"
        var lastChangeDate = dateGetFullDateString(date: Date())
        
        cell.configureView(walletName: name, sum: sum, currencySymbol: currencySymbol, lastChangeDate: lastChangeDate)
        
        XCTAssertEqual(cell.name.text, name)
        XCTAssertEqual(cell.currencySymbol.text, currencySymbol)
        XCTAssertEqual(cell.lastChangeDate.text, lastChangeDate)
        XCTAssertEqual(cell.sum.text, sum)
        
        // check if date lables are hidden when sum doesn't exist
        lastChangeDate = ""
         
        cell.configureView(walletName: name, sum: sum, currencySymbol: currencySymbol, lastChangeDate: lastChangeDate)
        
        XCTAssertTrue(cell.lastChangeTitle.isHidden)
        XCTAssertTrue(cell.lastChangeDate.isHidden)
    }

}
