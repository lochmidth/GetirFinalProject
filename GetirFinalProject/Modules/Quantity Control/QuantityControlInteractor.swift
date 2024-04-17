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
        Task {
            product.quantity += 1
            do {
                try await CartService.shared.addProductToCart(product)
                await MainActor.run {
                    presenter.didChangeCount(product.quantity)
                }
            } catch {
                print("Error increasing count: \(error)")
            }
        }
    }
    
    func decreaseCount() {
        Task {
            if product.quantity > 0 {
                product.quantity -= 1
                do {
                    try await CartService.shared.removeProductFromCart(product)
                    await MainActor.run {
                        presenter.didChangeCount(product.quantity)
                    }
                } catch {
                    print("Error decreasing count: \(error)")
                }
            }
        }
    }
}
