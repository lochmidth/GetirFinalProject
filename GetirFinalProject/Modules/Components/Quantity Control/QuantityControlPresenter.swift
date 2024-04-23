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

protocol QuantityControlDelegate: AnyObject {
    func didQuantityChange(_ count: Int)
}

protocol ProductDetailDelegate: AnyObject {
    func didQuantityChange(_ count: Int)
}

protocol BasketDelegate: AnyObject {
    func didQuantityChange(for product: Product)
}

final class QuantityControlPresenter {
    
    //MARK: - Properties
    
    weak var view: QuantitiyControlViewInput!
    var interactor: QuantityControlInteractorInput
    weak var cellPresenterDelegate: QuantityControlDelegate?
    weak var productDetailDelegate: ProductDetailDelegate?
    weak var basketDelegate: BasketDelegate?
    
    //MARK: - Lifecycle
    
    init(interactor: QuantityControlInteractorInput) {
        self.interactor = interactor
    }
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
    }
    
    func didTapMinus() {
        view.enableButtons(false)
        interactor.decreaseCount()
    }
}

extension QuantityControlPresenter: QuantityControlInteractorOutput {
    func didChangeCount(_ count: Int) {
        view.updateWithCount(interactor.product.quantity)
        cellPresenterDelegate?.didQuantityChange(count)
        productDetailDelegate?.didQuantityChange(count)
        basketDelegate?.didQuantityChange(for: interactor.product)
        view.enableButtons(true)
    }
}
