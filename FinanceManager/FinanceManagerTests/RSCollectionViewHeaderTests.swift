//
//  RSCollectionViewHeaderTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSCollectionViewHeaderTests: XCTestCase {

    var header: RSCollectionViewHeader!

    override func setUp() {
        super.setUp()
        guard let header = UINib(nibName: "RSCollectionViewHeader", bundle: nil).instantiate(withOwner: self, options: nil).first as? RSCollectionViewHeader else {
            XCTFail("Header was not initialized")
            return
        }
        self.header = header
    }

    override func tearDown() {
        header = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertNotNil(header)
        XCTAssertNotNil(header.title)

    }
    
    func test_backButtonPressed() {
        var backButtonDidPressCounter = 0
        header.backButtonDidPress = {
            backButtonDidPressCounter += 1
        }
        header.backButtonPressed(UIButton())
        XCTAssertEqual(backButtonDidPressCounter, 1)
    }

}
