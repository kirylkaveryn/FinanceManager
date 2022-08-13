//
//  RSBackgroundImageTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSBackgroundImageTests: XCTestCase {

    var backgroundImage: RSBackgroundImage!

    override func setUp() {
        super.setUp()
        backgroundImage = RSBackgroundImage()
    }

    override func tearDown() {
        backgroundImage = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertNotNil(backgroundImage)
    }
    
    func test_changeImage() {
        let image = RSThemeImageViews[0]
         
        backgroundImage.changeImage(with: image)
        XCTAssertTrue(backgroundImage.image == image)
        
    }

}
