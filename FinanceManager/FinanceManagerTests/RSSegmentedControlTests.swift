//
//  RSSegmentedControlTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSSegmentedControlTests: XCTestCase {

    var segmentedControl: RSSegmentedControl!

    override func setUp() {
        super.setUp()
        segmentedControl = RSSegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }

    override func tearDown() {
        segmentedControl = nil
        super.tearDown()
    }
    
    func test_segmentedControlSetup() {
        XCTAssertNotNil(segmentedControl)
        XCTAssertTrue(segmentedControl.segmentControlState == .outcome)
        segmentedControl.changeState()
        XCTAssertTrue(segmentedControl.segmentControlState == .income)
        
        segmentedControl.changeStateTo(state: .outcome)
        XCTAssertTrue(segmentedControl.segmentControlState == .outcome)
        
    }


}

