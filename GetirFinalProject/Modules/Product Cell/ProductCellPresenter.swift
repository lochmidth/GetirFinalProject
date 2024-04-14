//
//  ProductCellPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

protocol ProductCellViewInput: AnyObject {
    func update(with product: Product)
    func updateBorderColorForCount(_ count: Int)
    func configureStack()
    func configureQuantityControl()
    
}

protocol ProductCellRouterInput: AnyObject {
//    var navigationController: UINavigationController { get }
    func goToDetail()
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
        self.quantityControlPresenter = quantityControlBuilder.build(with: .vertical)
        guard let quantityControlPresenter else { return }
        quantityControlPresenter.delegate = self
    }
}

extension ProductCellPresenter: ProductCellViewOutput {
    func didLoadCell() {
        view.configureStack()
        view.configureQuantityControl()
        view.update(with: self.product)
    }
    
    func didTapCell() {
        router.goToDetail()
    }
}

extension ProductCellPresenter: QuantityControlDelegate {
    func didQuantityChange(_ count: Int) {
        view.updateBorderColorForCount(count)
    }
}
