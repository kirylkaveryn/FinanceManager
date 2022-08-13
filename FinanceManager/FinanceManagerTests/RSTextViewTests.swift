//
//  RSTextViewTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 9.10.21.
//

import XCTest
@testable import FinanceManager

class RSTextViewTests: XCTestCase {

    var textField: RSTextView!

    override func setUp() {
        super.setUp()
        
        textField = RSTextView()
    }
    
    override func tearDown() {
        textField = nil
        
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(textField)
        XCTAssertEqual(textField.text, textField.placeholder)
    }

}
