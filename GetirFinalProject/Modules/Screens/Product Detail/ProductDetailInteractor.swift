//
//  ProductDetailInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import Foundation

protocol ProductDetailInteractorOutput: AnyObject {
    func didIncreaseCountForProduct(_ count: Int)
}

final class ProductDetailInteractor {

    weak var presenter: ProductDetailInteractorOutput!
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}

extension ProductDetailInteractor: ProductDetailInteractorInput {
    func increaseCount() {
        //Handle Cart
        product.quantity += 1
        presenter.didIncreaseCountForProduct(product.quantity)
    }
}
