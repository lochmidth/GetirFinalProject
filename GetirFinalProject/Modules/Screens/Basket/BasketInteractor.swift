//
//  BasketInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import Foundation
import GetirSDK

protocol BasketInteractorOutput: AnyObject {
    func didUpdateProductList(withPrice priceText: String)
    func didClearCart()
    func didCheckout()
    func didFail(with error: Error)
}

final class BasketInteractor {
    
    weak var presenter: BasketInteractorOutput!
    let getirService: GetirSDK
    var productList: ProductList
    var suggestedProductList: SuggestedProductList
    
    init(getirService: GetirSDK = GetirSDK()) {
        self.getirService = getirService
        self.productList = ProductList()
        self.suggestedProductList = SuggestedProductList()
    }
    
}

extension BasketInteractor: BasketInteractorInput {
    func addToCart(_ product: Product) {
//        let isAlreadyInCart = CartService.shared.products.contains(where: { $0.id == product.id })
//        if !isAlreadyInCart {
//            if let index = self.suggestedProductList.products.firstIndex(where: { $0.product.id == product.id }) {
//                self.productList.products.append(suggestedProductList.products[index])
//            }
//            let priceText = CartService.shared.totalPrice
//            presenter.didUpdateProductList(withPrice: priceText)
//        } else {
//            if let index = CartService.shared.products.firstIndex(where: { $0.id == product.id }) {
//                CartService.shared.products[index].quantity += 1
//                let priceText = CartService.shared.totalPrice
//                presenter.didUpdateProductList(withPrice: priceText)
//            }
//        }
    }
    
    func checkout() {
        Task {
            do {
                try await CartService.shared.removeAllProductsFromCart()
                presenter.didCheckout()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
    
    
    func clearProduct(_ product: Product) {
        Task {
            do {
                try await CartService.shared.removeProductFromCart(product)
                if let index = productList.products.firstIndex(where: { $0.product.id == product.id }) {
                    productList.products.remove(at: index)
                    if let suggestedProductIndex = suggestedProductList.products.firstIndex(where: { $0.product.id == product.id }) {
                        suggestedProductList.products[suggestedProductIndex].product.quantity -= 1
                    }
                }
                if productList.products.count == 0 {
                    presenter.didClearCart()
                } else {
                    let priceText = CartService.shared.totalPrice
                    presenter.didUpdateProductList(withPrice: priceText)
                }
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
    
    func handleClearAllProducts() {
        Task {
            do {
                try await CartService.shared.removeAllProductsFromCart()
                presenter.didClearCart()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
    
    func fetchProducts() {
        Task {
            do {
                let suggestedProductsDTO = try await getirService.fetchSuggestedProducts()
                self.suggestedProductList.update(from: suggestedProductsDTO)
                self.suggestedProductList.products = try await CartService.shared.updateQuantity(for: suggestedProductList.products, addCart: false)
                self.productList.products = CartService.shared.products.compactMap {
                    let presenter = ProductCellPresenter(product: $0)
                    presenter.configureQuantityControlPresenter()
                    return presenter
                }
                let priceText = CartService.shared.totalPrice
                presenter.didUpdateProductList(withPrice: priceText)
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
