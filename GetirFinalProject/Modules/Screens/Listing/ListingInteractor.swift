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
}

extension ListingInteractor: ListingInteractorInput {
    func fetchAllProducts() {
        Task {
            do {
                let suggestedProductsDTO = try await getirService.fetchSuggestedProducts()
                let productsDTO = try await getirService.fetchProducts()
                self.productList.update(from: productsDTO)
                self.suggestedProductList.update(from: suggestedProductsDTO)
                self.productList.products = try await CartService.shared.updateQuantity(for: self.productList.products)
                self.suggestedProductList.products = try await CartService.shared.updateQuantity(for: self.suggestedProductList.products)
                presenter.didReceiveAllProducts()
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
