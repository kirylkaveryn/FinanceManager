//
//  DateConverterTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 5.10.21.
//

import XCTest
@testable import FinanceManager

class DateConverterTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func test_dateConvertDateFromString() {
        let date = "2020-05-25"
        XCTAssertEqual(dateConvertDateFromString(inputDate: date), "May 25, 2020")
    }
    
    func test_dateGetCurrentDateString() {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, YYYY"
        
        XCTAssertEqual(dateGetCurrentDateString(), outputFormatter.string(from:  Date()))
    }
    
    func test_dateGetFullDateString() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(dateGetFullDateString(date: date), "January 1, 1970")
        XCTAssertNotEqual(dateGetFullDateString(date: date), "January 2, 1970")

    }
    
    func test_dateGetShortDateString() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(dateGetShortDateString(date: date), "1 Jan")
        XCTAssertNotEqual(dateGetShortDateString(date: date), "2 Jan")
    }

}
