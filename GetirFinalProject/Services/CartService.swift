//
//  CartService.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 17.04.2024.
//

import Foundation

protocol CartServiceProtocol {
    var totalPrice: String { get }
    var products: [Product] { get set }
    func updateQuantity(for products: [Product]) async throws -> [Product]
    func updateQuantity(for productPresenters: [ProductCellPresenter], addCart: Bool) async throws -> [ProductCellPresenter]
    func addProductToCart(_ product: Product) async throws
    func removeProductFromCart(_ product: Product) async throws
    func removeAllProductsFromCart() async throws
    func checkout() async throws -> Bool
}

final class CartService: CartServiceProtocol {
    static let shared = CartService()
    
    private let coreDataManager: CoreDataManagerProtocol
    var totalPrice: String = "₺0,00"
    var products = [Product]() {
        didSet {
            calculateTotalPrice()
        }
    }
    
    //I'm aware that this init must be private due to fact that Cart is a singleton. However, I made it internal so that I can test it.
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    private func calculateTotalPrice() {
        let totalPriceDouble = products.reduce(0) { (result, product) -> Double in
            return result + (product.price * Double(product.quantity))
        }
        let formattedTotalPrice = String(format: "₺%.2f", totalPriceDouble)
        totalPrice = formattedTotalPrice
        NotificationCenter.default.post(name: .didCalculateTotalPrice, object: nil)
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
            self.products = updatedProducts.filter { $0.quantity > 0 }
            return updatedProducts
        } catch {
            throw error
        }
    }
    
    func updateQuantity(for productPresenters: [ProductCellPresenter], addCart: Bool) async throws -> [ProductCellPresenter] {
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
            let updatedProducts = updatedProductPresenters.map { $0.product }
            if addCart {
                self.products += updatedProducts.filter { $0.quantity > 0 }
            }
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
        try await coreDataManager.deleteAllData()
        products.removeAll()
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
