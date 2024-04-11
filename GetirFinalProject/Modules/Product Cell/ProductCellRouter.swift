//
//  ProductCellRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class ProductCellRouter {
    var navigationController: UINavigationController
    let quantityControlBuilder: QuantityControlBuilder
    
    init(navigationController: UINavigationController, quantityControlBuilder: QuantityControlBuilder) {
        self.navigationController = navigationController
        self.quantityControlBuilder = quantityControlBuilder
    }
}

extension ProductCellRouter: ProductCellRouterInput {
    func buildQuantityControl() -> QuantityControlView {
        return quantityControlBuilder.build(with: navigationController, orientation: .vertical)
    }
}
