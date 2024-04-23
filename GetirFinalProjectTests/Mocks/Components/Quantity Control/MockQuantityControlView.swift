//
//  MockQuantityControlView.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockQuantityControlView: QuantitiyControlViewInput {
    var count: Int?
    var bool: Bool?
    
    var isUpdateWithCountCalled = false
    func updateWithCount(_ count: Int) {
        self.count = count
        isUpdateWithCountCalled = true
    }
    
    var isConfigureStackOrientationCalled = false
    func configureStackOrientation() {
        isConfigureStackOrientationCalled = true
    }
    
    var isEnableButtonsCalled = false
    func enableButtons(_ bool: Bool) {
        self.bool = bool
        isEnableButtonsCalled = true
    }
}
