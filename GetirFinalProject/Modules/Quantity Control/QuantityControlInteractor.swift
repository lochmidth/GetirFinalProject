//
//  QuantityControlInteractor.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantityControlInteractorOutput: AnyObject {
    func didChangeCount(_ count: Int)
}

final class QuantityControlInteractor {
    weak var presenter: QuantityControlInteractorOutput!
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}

extension QuantityControlInteractor: QuantityControlInteractorInput {
    func increaseCount() {
        //Handle in cart
        product.quantity += 1
        presenter.didChangeCount(product.quantity)
    }
    
    func decreaseCount() {
        //Handle in cart
        if product.quantity > 0 {
            product.quantity -= 1
            presenter.didChangeCount(product.quantity)
        }
    }
}
