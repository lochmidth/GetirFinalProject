//
//  MockProductDetailInteractor.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductDetailInteractor: ProductDetailInteractorInput {
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var isUpdateProductCalled = false
    func updateProduct() {
        isUpdateProductCalled = true
    }
}
