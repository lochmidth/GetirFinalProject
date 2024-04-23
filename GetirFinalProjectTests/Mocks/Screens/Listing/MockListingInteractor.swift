//
//  MockListingInteractor.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockListingInteractor: ListingInteractorInput {
    var productList: ProductList
    var suggestedProductList: SuggestedProductList
    
    init() {
        self.productList = ProductList()
        self.suggestedProductList = SuggestedProductList()
    }
    
    var isFecthAllProductsCalled = false
    func fetchAllProducts() {
        isFecthAllProductsCalled = true
    }
    
    var isUpdateAllProductsCalled = false
    func updateAllProducts() {
        isUpdateAllProductsCalled = true
    }
}
