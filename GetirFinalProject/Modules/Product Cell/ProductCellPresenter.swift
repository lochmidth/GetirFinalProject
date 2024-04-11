//
//  ProductCellPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import Foundation

protocol ProductCellViewInput: AnyObject {
    func changeBorderColor()
    func configureSubviews()
    func configureQuantityControl()
    
}

protocol ProductCellRouterInput: AnyObject {
    func buildQuantityControl() -> QuantityControlView
}

final class ProductCellPresenter {
    
    weak var view: ProductCellViewInput!
    var router: ProductCellRouterInput!
    
    init(view: ProductCellViewInput!, router: ProductCellRouterInput!) {
        self.view = view
        self.router = router
    }
}

extension ProductCellPresenter: ProductCellViewOutput {
    func configureQuantityControl() -> QuantityControlView {
        return router.buildQuantityControl()
    }
    
    func didLoadCell() {
        view.configureSubviews()
        view.configureQuantityControl()
    }
    
    func didTapCell() {
        //Handle show Product Detail
        view.changeBorderColor()
    }
}
