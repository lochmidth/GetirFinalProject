//
//  CartService.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 17.04.2024.
//

import Foundation

final class CartService {
    static let shared = CartService()
    
    private let coreDataManager: CoreDataManager
    var products = [Product]()
    
    private init(coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchProductsInCart() async throws -> [(id: String, quantity: Int)] {
        do {
            return try await coreDataManager.fetchAllCoreData()
        } catch {
            throw error
        }
    }
    
    func addProductToCart(_ product: Product) async throws {
        let productsInCart = try await coreDataManager.fetchAllCoreData()
        if let index = productsInCart.firstIndex(where: { $0.id == product.id }) {
            let newQuantity = productsInCart[index].quantity + 1
            try await coreDataManager.updateProductQuantity(id: product.id, newQuantity: newQuantity)
        } else {
            try await coreDataManager.addToCoreData(forProduct: product)
        }
    }
}
