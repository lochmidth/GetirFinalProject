//
//  QuantityControlPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import Foundation

protocol QuantitiyControlViewInput: AnyObject {
    func updateWithCount(_ count: Int)
    func configureStackOrientation()
}

protocol QuantityControlInteractorInput: AnyObject {
    var count: Int { get }
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
//    var router: QuantityControlRouterInput
    weak var delegate: QuantityControlDelegate?
    
    //MARK: - Lifecycle
    
    init(interactor: QuantityControlInteractorInput) {
        self.interactor = interactor
    }
    
    //MARK: - Helpers
    
}

extension QuantityControlPresenter: QuantitiyControlViewOutput {
    func didLoadQuantityControl() {
        view.configureStackOrientation()
        delegate?.didQuantityChange(interactor.count)
        view.updateWithCount(interactor.count)
    }
    
    func didTapPlus() {
        //Handle Cart
        interactor.increaseCount()
        delegate?.didQuantityChange(interactor.count)
        view.updateWithCount(interactor.count)
    }
    
    func didTapMinus() {
        //Handle Cart
        interactor.decreaseCount()
        delegate?.didQuantityChange(interactor.count)
        view.updateWithCount(interactor.count)
    }
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    
}
