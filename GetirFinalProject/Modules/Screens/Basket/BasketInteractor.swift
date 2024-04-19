//
//  BasketInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import Foundation
import GetirSDK

protocol BasketInteractorOutput: AnyObject {
    func didReceiveAllProducts()
    func didClearCart()
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
                self.suggestedProductList.products = try await CartService.shared.updateQuantity(for: suggestedProductList.products)
                self.productList.products = CartService.shared.products.compactMap {
                    let presenter = ProductCellPresenter(product: $0)
                    presenter.configureQuantityControlPresenter()
                    return presenter
                }
                presenter.didReceiveAllProducts()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
