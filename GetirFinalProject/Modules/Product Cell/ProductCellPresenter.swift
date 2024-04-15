//
//  ProductCellPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

protocol ProductCellViewInput: AnyObject {
    func update(with product: Product)
    func updateWithCount(_ count: Int)
    func configureStack()
    func configureQuantityControl()
    
}

protocol ProductCellRouterInput: AnyObject {
    func goToDetail(with product: Product, cellPresenter: ProductCellPresenter)
}

final class ProductCellPresenter {
    
    weak var view: ProductCellViewInput!
    var router: ProductCellRouterInput!
    var product: Product
    var quantityControlBuilder: QuantityControlBuilder
    var quantityControlPresenter: QuantityControlPresenter?
    
    init(product: Product, quantityControlBuilder: QuantityControlBuilder = QuantityControlBuilder()) {
        self.product = product
        self.quantityControlBuilder = quantityControlBuilder
    }
    
    func configureQuantityControlPresenter(){
        self.quantityControlPresenter = quantityControlBuilder.build(with: product)
        guard let quantityControlPresenter else { return }
        quantityControlPresenter.cellPresenterDelegate = self
    }
}

extension ProductCellPresenter: ProductCellViewOutput {
    func didLoadCell() {
        view.configureStack()
        view.configureQuantityControl()
        view.update(with: self.product)
    }
    
    func didTapCell() {
        router.goToDetail(with: product, cellPresenter: self)
    }
}

extension ProductCellPresenter: QuantityControlDelegate {
    func didQuantityChange(_ count: Int) {
        product.quantity = count
        view.updateWithCount(product.quantity)
        quantityControlPresenter?.interactor.product.quantity = count
    }
}
