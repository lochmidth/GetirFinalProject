//
//  QuantityControlPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantitiyControlViewInput: AnyObject {
    
}

protocol QuantityControlInteractorInput: AnyObject {
    func addToCart()
    func removeFromCart()
}

protocol QuantityControlRouterInput: AnyObject {
    
}

final class QuantityControlPresenter {
    
    //MARK: - Properties
    
    private weak var view: QuantitiyControlViewInput!
    var interactor: QuantityControlInteractorInput
    var router: QuantityControlRouterInput
    
    //MARK: - Lifecycle
    
    init(view: QuantitiyControlViewInput!, interactor: QuantityControlInteractorInput, router: QuantityControlRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Helpers
    
}

extension QuantityControlPresenter: QuantitiyControlViewOutput {
    func incrementQuantity() {
        //Handle Cart
    }
    
    func decrementQuantity() {
        //Handle Cart
    }
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    
}
