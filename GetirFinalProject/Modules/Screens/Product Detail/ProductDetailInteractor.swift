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
    
    init(product: Product) {
        self.product = product
    }
}

extension ProductDetailInteractor: ProductDetailInteractorInput {
    
}
