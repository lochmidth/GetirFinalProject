//
//  MockGetirService.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import Foundation
@testable import GetirSDK
@testable import GetirFinalProject

final class MockGetirService: GetirServiceProtocol {
    
    var isFetchProductsCalled = false
    var fetchProductsResult: Result<ProductListDTO,Error>?
    func fetchProducts() async throws -> GetirSDK.ProductListDTO {
        isFetchProductsCalled = true
        if let result = fetchProductsResult {
            switch result {
            case .success(let productListDTO):
                return productListDTO
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
        
    }
    
    var isFetchSuggestedProductsCalled = false
    var fetchSuggestedProductsResult: Result<SuggestedProductListDTO,Error>?
    func fetchSuggestedProducts() async throws -> GetirSDK.SuggestedProductListDTO {
        isFetchSuggestedProductsCalled = true
        if let result = fetchSuggestedProductsResult {
            switch result {
            case .success(let suggestedProductListDTO):
                return suggestedProductListDTO
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
}
