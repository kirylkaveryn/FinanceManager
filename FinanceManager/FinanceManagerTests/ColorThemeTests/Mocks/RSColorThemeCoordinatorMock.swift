//
//  RSColorThemeCoordinatorMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 8.10.21.
//

import XCTest
@testable import FinanceManager

class RSColorThemeCoordinatorMock: RSColorThemeCoordinatorProtocol {
    
    var backButtonIsPressed = false
    var colorThemeCellPressed = false
    
    var themeIndex: Int?
    
    func backButtonDidPress() {
        backButtonIsPressed = true
    }
    
    func colorThemeCellDidSelect(themeIndex: Int) {
        colorThemeCellPressed = true
        self.themeIndex = themeIndex
    }
    


}
