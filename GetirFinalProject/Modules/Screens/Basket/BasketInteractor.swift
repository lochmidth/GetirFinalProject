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
    let getirService: GetirService
    var productList: ProductList
    var suggestedProductList: SuggestedProductList
    let cartService: CartService
    
    init(getirService: GetirService = GetirService(), cartService: CartService = CartService.shared) {
        self.getirService = getirService
        self.cartService = cartService
        self.productList = ProductList()
        self.suggestedProductList = SuggestedProductList()
    }
    
}

extension BasketInteractor: BasketInteractorInput {
    func adjustCart(with product: Product) {
        fetchProducts()
    }
    
    func checkout() {
        Task {
            do {
                try await cartService.removeAllProductsFromCart()
                presenter.didCheckout()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
    
    
    func clearProduct(_ product: Product) {
        Task {
            do {
                try await cartService.removeProductFromCart(product)
                if let index = productList.products.firstIndex(where: { $0.product.id == product.id }) {
                    productList.products.remove(at: index)
                    if let suggestedProductIndex = suggestedProductList.products.firstIndex(where: { $0.product.id == product.id }) {
                        suggestedProductList.products[suggestedProductIndex].product.quantity -= 1
                    }
                }
                if productList.products.count == 0 {
                    presenter.didClearCart()
                } else {
                    let priceText = cartService.totalPrice
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
                try await cartService.removeAllProductsFromCart()
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
                self.suggestedProductList.products = try await cartService.updateQuantity(for: suggestedProductList.products, addCart: false)
                self.productList.products = cartService.products.compactMap {
                    let presenter = ProductCellPresenter(product: $0)
                    return presenter
                }
                if productList.products.isEmpty {
                    presenter.didClearCart()
                } else {
                    let priceText = cartService.totalPrice
                    presenter.didUpdateProductList(withPrice: priceText)
                }
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
