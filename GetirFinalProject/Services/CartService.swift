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
    var totalPrice: Double = 0
    var products = [Product]() {
        didSet {
            calculateTotalPrice()
        }
    }
    
    private init(coreDataManager: CoreDataManager = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    private func calculateTotalPrice() {
        totalPrice = products.reduce(0) { (result, product) -> Double in
            return result + (product.price * Double(product.quantity))
        }
        totalPrice = (totalPrice * 100).rounded() / 100
    }
    
    func updateQuantity(for products: [Product]) async throws -> [Product] {
        do {
            let idsAndQuantities = try await coreDataManager.fetchAllCoreData()
            var updatedProducts = products
            let fetchedProductDictionary = Dictionary(uniqueKeysWithValues: idsAndQuantities.map { ($0.id, $0.quantity) })
            for (index, product) in updatedProducts.enumerated() {
                if let newQuantity = fetchedProductDictionary[product.id] {
                    updatedProducts[index].quantity = newQuantity
                }
            }
            self.products = updatedProducts
            return updatedProducts
        } catch {
            throw error
        }
    }
    
    func updateQuantity(for productPresenters: [ProductCellPresenter]) async throws -> [ProductCellPresenter] {
        do {
            let idsAndQuantities = try await coreDataManager.fetchAllCoreData()
            let fetchedProductDictionary = Dictionary(uniqueKeysWithValues: idsAndQuantities.map { ($0.id, $0.quantity) })
            let updatedProductPresenters = productPresenters
            for index in updatedProductPresenters.indices {
                let productId = updatedProductPresenters[index].product.id
                if let newQuantity = fetchedProductDictionary[productId] {
                    updatedProductPresenters[index].product.quantity = newQuantity
                    updatedProductPresenters[index].view?.updateWithCount(newQuantity)
                }
            }
            self.products += updatedProductPresenters.map { $0.product }
            return updatedProductPresenters
        } catch {
            throw error
        }
    }

    func addProductToCart(_ product: Product) async throws {
        let productsInCart = try await coreDataManager.fetchAllCoreData()
        if let index = productsInCart.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
            let newQuantity = productsInCart[index].quantity + 1
            try await coreDataManager.updateProductQuantity(id: product.id, newQuantity: newQuantity)
        } else {
            products.append(product)
            try await coreDataManager.addToCoreData(forProduct: product)
        }
    }
    
    func removeProductFromCart(_ product: Product) async throws {
        let productsInCart = try await coreDataManager.fetchAllCoreData()
        if let index = productsInCart.firstIndex(where: { $0.id == product.id }) {
            if products[index].quantity > 1 {
                products[index].quantity -= 1
                let newQuantity = productsInCart[index].quantity - 1
                try await coreDataManager.updateProductQuantity(id: product.id, newQuantity: newQuantity)
            } else {
                products.removeAll { $0.id == product.id }
                try await coreDataManager.deleteCoreData(forProduct: product)
            }
        }
    }
    
    func removeAllProductsFromCart() async throws {
        products.removeAll()
        try await coreDataManager.deleteAllData()
    }
    
    func checkout() async throws -> Bool {
        if !products.isEmpty {
            do {
                try await removeAllProductsFromCart()
                return true
            } catch {
                throw error
            }
        } else {
            return false
        }
    }
}
