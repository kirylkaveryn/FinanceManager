//
//  CurrencyConverterTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 5.10.21.
//

import XCTest
@testable import FinanceManager

class CurrencyConverterTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func test_currencySymbolByCode() {
        let currencyCode = "USD"
        let currencySymbol = currencySymbolByCode(code: currencyCode)
        
        XCTAssertEqual(currencySymbol, "$")
    }
    
    func test_currencySymbolByCode_wrongCode() {
        let currencyCode = "x"
        let currencySymbol = currencySymbolByCode(code: currencyCode)
        
        XCTAssertEqual(currencySymbol, "")
    }
    
    func test_currencyNameByCode() {
        let currencyCode = "USD"
        let currencName = currencyNameByCode(code: currencyCode)
        
        XCTAssertEqual(currencName, "US Dollar")
    }
    
    
    func test_currencyNameByCode_wrongName() {
        let currencyCode = "x"
        XCTAssertNil(currencyNameByCode(code: currencyCode))
    }
    
    func test_currencyLabelWithSpace() {
        let currencyCode = "USD"
        let currencyLabel = currencyLabelWithSpace(currency: currencyCode)
        
        XCTAssertEqual(currencyLabel, "USD $")
    }
    
    func test_currencyLabelWithSpace_wrongCode() {
        let currencyCode = "x"
        let currencyLabel = currencyLabelWithSpace(currency: currencyCode)
        
        XCTAssertEqual(currencyLabel, "")
    }


}
