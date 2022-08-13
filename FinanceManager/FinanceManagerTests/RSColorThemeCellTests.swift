//
//  RSColorThemeCellTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest

import XCTest
@testable import FinanceManager

class RSColorThemeCellTests: XCTestCase {

    var cell: RSColorThemeCell!

    override func setUp() {
        super.setUp()
        guard let cell = UINib(nibName: "RSColorThemeCell", bundle: nil).instantiate(withOwner: self, options: nil).first as? RSColorThemeCell else {
            return
        }
        self.cell = cell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.imageView)
    }

}
