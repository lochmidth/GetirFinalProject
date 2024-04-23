//
//  MockProductCellView.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductCellView: ProductCellViewInput {
    var product: Product?
    var count: Int?
    
    var isUpdateWithProductCalled = false
    func update(with product: Product) {
        self.product = product
        isUpdateWithProductCalled = true
    }
    
    var isUpdateWithCountCalled = false
    func updateWithCount(_ count: Int) {
        self.count = count
        isUpdateWithCountCalled = true
    }
    
    var isConfigureStackCalled = false
    func configureStack() {
        isConfigureStackCalled = true
    }
    
    var isConfigureQuantityControlCalled = false
    func configureQuantityControl(with count: Int) {
        self.count = count
        isConfigureQuantityControlCalled = true
    }
}
