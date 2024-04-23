//
//  MockCartService.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockCartService: CartServiceProtocol {
    var products: [GetirFinalProject.Product]
    
    var totalPrice: String
    
    init() {
        totalPrice = mockProduct1.priceText
        products = mockProducts
    }
    
    var isUpdateQuantityCalled = false
    var updateQuantityResult: Result<[Product],Error>?
    func updateQuantity(for products: [Product]) async throws -> [Product] {
        isUpdateQuantityCalled = true
        if let result = updateQuantityResult {
            switch result {
            case .success(let products):
                return products
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isUpdateQuantityForCellPresenterCalled = false
    var updateQuantityForCellPresenterResult: Result<[ProductCellPresenter],Error>?
    func updateQuantity(for productPresenters: [ProductCellPresenter], addCart: Bool) async throws -> [ProductCellPresenter] {
        isUpdateQuantityForCellPresenterCalled = true
        if let result = updateQuantityForCellPresenterResult {
            switch result {
            case .success(let cellPresenters):
                return cellPresenters
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isAddProductToCartCalled = false
    var addProductToCartResult: Result<Void,Error>?
    func addProductToCart(_ product: Product) async throws {
        isAddProductToCartCalled = true
        if let result = addProductToCartResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isRemoveProductFromCartCalled = false
    var removeProductFromCartResult: Result<Void,Error>?
    func removeProductFromCart(_ product: Product) async throws {
        isRemoveProductFromCartCalled = true
        if let result = removeProductFromCartResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isRemoveAllProductsFromCartCalled = false
    var RemoveAllProductsFromCartResult: Result<Void,Error>?
    func removeAllProductsFromCart() async throws {
        isRemoveAllProductsFromCartCalled = true
        if let result = RemoveAllProductsFromCartResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isCheckoutCalled = false
    var checkoutResult: Result<Bool,Error>?
    func checkout() async throws -> Bool {
        isCheckoutCalled = true
        if let result = checkoutResult {
            switch result {
            case .success(let bool):
                return bool
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    
}
