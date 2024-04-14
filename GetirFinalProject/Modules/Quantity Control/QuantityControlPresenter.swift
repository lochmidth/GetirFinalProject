//
//  QuantityControlPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantitiyControlViewInput: AnyObject {
    func updateWithCount(_ count: Int)
}

protocol QuantityControlInteractorInput: AnyObject {
    func increaseCount()
    func decreaseCount()
}

protocol QuantityControlRouterInput: AnyObject {
    
}

protocol QuantityControlDelegate: AnyObject {
    func didQuantityChange(_ count: Int)
}

final class QuantityControlPresenter {
    
    //MARK: - Properties
    
    weak var view: QuantitiyControlViewInput!
    var interactor: QuantityControlInteractorInput
    var router: QuantityControlRouterInput
    weak var delegate: QuantityControlDelegate?
    var count = 0
    
    //MARK: - Lifecycle
    
    init(interactor: QuantityControlInteractorInput, router: QuantityControlRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Helpers
    
}

extension QuantityControlPresenter: QuantitiyControlViewOutput {
    func didTapPlus() {
        //Handle Cart
        interactor.increaseCount()
        delegate?.didQuantityChange(count)
        view.updateWithCount(count)
    }
    
    func didTapMinus() {
        //Handle Cart
        interactor.decreaseCount()
        delegate?.didQuantityChange(count)
        view.updateWithCount(count)
    }
    
  
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    
}
