//
//  ListingInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation
import GetirSDK

protocol ListingInteractorOutput: AnyObject {
    func didReceiveAllProducts()
    func didFail(with error: Error)
}

final class ListingInteractor {
    
    weak var presenter: ListingInteractorOutput!
    let getirService: GetirSDK
    var productList: ProductList
    var suggestedProductList: SuggestedProductList
    
    init(getirService: GetirSDK = GetirSDK()) {
        self.getirService = getirService
        self.productList = ProductList()
        self.suggestedProductList = SuggestedProductList()
    }
    
    private func didClearBasket() {
        self.productList.products.forEach { productCellPresenter in
            productCellPresenter.product.quantity = 0
        }
        self.suggestedProductList.products.forEach { productCellPresenter in
            productCellPresenter.product.quantity = 0
        }
        presenter.didReceiveAllProducts()
    }
    
    private func updateProductsFromCart() {
        CartService.shared.products.forEach { product in
            if let index = productList.products.firstIndex(where: { $0.product.id == product.id }) {
                productList.products[index].product.quantity = product.quantity
            }
            if let index = suggestedProductList.products.firstIndex(where: { $0.product.id == product.id }) {
                suggestedProductList.products[index].product.quantity = product.quantity
            }
        }
    }
}

extension ListingInteractor: ListingInteractorInput {
    func updateAllProducts() {
        didClearBasket()
        updateProductsFromCart()
        presenter.didReceiveAllProducts()
    }
    
    func fetchAllProducts() {
        Task {
            do {
                let suggestedProductsDTO = try await getirService.fetchSuggestedProducts()
                let productsDTO = try await getirService.fetchProducts()
                self.productList.update(from: productsDTO)
                self.suggestedProductList.update(from: suggestedProductsDTO)
                self.productList.products = try await CartService.shared.updateQuantity(for: self.productList.products, addCart: true)
                self.suggestedProductList.products = try await CartService.shared.updateQuantity(for: self.suggestedProductList.products, addCart: true)
                presenter.didReceiveAllProducts()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
