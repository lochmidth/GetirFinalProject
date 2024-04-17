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
    func enableButtons(_ bool: Bool)
}

protocol QuantityControlInteractorInput: AnyObject {
    var product: Product { get set }
    func increaseCount()
    func decreaseCount()
}

protocol QuantityControlRouterInput: AnyObject {
    
}

protocol QuantityControlDelegate: AnyObject {
    func didQuantityChange(_ count: Int)
}

protocol ProductDetailDelegate: AnyObject {
    func didQuantityChange(_ count: Int)
}

final class QuantityControlPresenter {
    
    //MARK: - Properties
    
    weak var view: QuantitiyControlViewInput!
    var interactor: QuantityControlInteractorInput
//    var router: QuantityControlRouterInput
    weak var cellPresenterDelegate: QuantityControlDelegate?
    weak var productDetailDelegate: ProductDetailDelegate?
    
    //MARK: - Lifecycle
    
    init(interactor: QuantityControlInteractorInput) {
        self.interactor = interactor
    }
    
    //MARK: - Helpers
    
}

extension QuantityControlPresenter: QuantitiyControlViewOutput {
    func didLoadQuantityControl() {
        view.configureStackOrientation()
        cellPresenterDelegate?.didQuantityChange(interactor.product.quantity)
        view.updateWithCount(interactor.product.quantity)
    }
    
    func didTapPlus() {
        view.enableButtons(false)
        interactor.increaseCount()
//        view.updateWithCount(interactor.product.quantity)
//        cellPresenterDelegate?.didQuantityChange(interactor.product.quantity)
    }
    
    func didTapMinus() {
        view.enableButtons(false)
        interactor.decreaseCount()
//        view.updateWithCount(interactor.product.quantity)
//        cellPresenterDelegate?.didQuantityChange(interactor.product.quantity)
//        productDetailDelegate?.didQuantityChange(interactor.product.quantity)
    }
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    func didChangeCount(_ count: Int) {
        view.updateWithCount(interactor.product.quantity)
        cellPresenterDelegate?.didQuantityChange(count)
        productDetailDelegate?.didQuantityChange(count)
        view.enableButtons(true)
    }
}
