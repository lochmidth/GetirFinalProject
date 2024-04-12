//
//  QuantityControlPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantitiyControlViewInput: AnyObject {
    func increaseCount()
    func decreaseCount()
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
    func didTapPlus() {
        //Handle Cart
        view.increaseCount()
    }
    
    func didTapMinus() {
        //Handle Cart
        view.decreaseCount()
    }
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    
}
