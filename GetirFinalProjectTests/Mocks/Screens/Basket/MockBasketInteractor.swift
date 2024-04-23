//
//  MockBasketInteractor.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockBasketInteractor: BasketInteractorInput {
    var productList: ProductList
    var suggestedProductList: SuggestedProductList
    
    init() {
        self.productList = ProductList()
        self.suggestedProductList = SuggestedProductList()
    }
    
    var isFetchProductsCalled = false
    func fetchProducts() {
        isFetchProductsCalled = true
    }
    
    var isAdjustCartCalled = false
    func adjustCart(with product: Product) {
        isAdjustCartCalled = true
    }
    
    var isCheckoutCalled = false
    func checkout() {
        isCheckoutCalled = true
    }
    
    var isClearProductCalled = false
    func clearProduct(_ product: Product) {
        isClearProductCalled = true
    }
    
    var isHandleClearAllProductsCalled = false
    func handleClearAllProducts() {
        isHandleClearAllProductsCalled = true
    }
}
