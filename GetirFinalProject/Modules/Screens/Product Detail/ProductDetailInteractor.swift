//
//  ProductDetailInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import Foundation

protocol ProductDetailInteractorOutput: AnyObject {
  
}

final class ProductDetailInteractor {
    weak var presenter: ProductDetailInteractorOutput!
    var product: Product
    let cartService: CartServiceProtocol
    
    init(product: Product, cartService: CartServiceProtocol = CartService.shared) {
        self.product = product
        self.cartService = cartService
    }
}

extension ProductDetailInteractor: ProductDetailInteractorInput {
    func updateProduct() {
        self.product = cartService.products.first(where: { $0.id == product.id }) ?? product
    }
}
