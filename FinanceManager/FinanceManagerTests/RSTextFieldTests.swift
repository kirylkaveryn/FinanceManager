//
//  RSTextFieldTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 6.10.21.
//

import XCTest
@testable import FinanceManager

class RSTextFieldTests: XCTestCase {

    var textField: RSTextField!

    override func setUpWithError() throws {
        super.setUp()
        
        textField = RSTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func tearDownWithError() throws {
        textField = nil
        
        super.tearDown()
    }
    
    func test_textFieldBounds() {
        XCTAssertNotNil(textField)
        XCTAssertEqual(textField.placeholderRect(forBounds: textField.bounds), CGRect(x: 15, y: 15, width: 70, height: 70))
        XCTAssertEqual(textField.textRect(forBounds: textField.bounds), CGRect(x: 15, y: 15, width: 70, height: 70))
        XCTAssertEqual(textField.editingRect(forBounds: textField.bounds), CGRect(x: 15, y: 15, width: 70, height: 70))
    }

}
