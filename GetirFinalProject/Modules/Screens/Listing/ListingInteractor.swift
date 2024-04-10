//
//  ListingInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation
import GetirSDK

protocol ListingInteractorOutput: AnyObject {
    func didReceiveAllProducts(_ products: ProductList, _ suggestedProducts: SuggestedProductList)
    func didFail(with error: Error)
}

final class ListingInteractor {
    
    weak var presenter: ListingInteractorOutput!
    let getirService: GetirSDK
    
    init(getirService: GetirSDK = GetirSDK()) {
        self.getirService = getirService
    }
}

extension ListingInteractor: ListingInteractorInput {
    func fetchAllProducts() {
        Task {
            do {
                let productsDTO = try await getirService.fetchProducts()
                let suggestedProductsDTO = try await getirService.fetchSuggestedProducts()
                let products = ProductList(from: productsDTO)
                let suggestedProducts = SuggestedProductList(from: suggestedProductsDTO)
                presenter.didReceiveAllProducts(products, suggestedProducts)
            } catch {
                presenter.didFail(with: error)
            }
        }
    }
}
