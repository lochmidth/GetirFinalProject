//
//  MockQuantityControlInteractor.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockQuantityControlInteractor: QuantityControlInteractorInput {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var isIncreaseCountCalled = false
    func increaseCount() {
        isIncreaseCountCalled = true
    }
    
    var isDecreaseCountCalled = false
    func decreaseCount() {
        isDecreaseCountCalled = true
    }
}
