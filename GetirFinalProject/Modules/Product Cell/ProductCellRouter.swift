//
//  ProductCellRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class ProductCellRouter {
    var navigationController: UINavigationController
    var productDetailBuilder: ProductDetailBuilder
    
    init(navigationController: UINavigationController, productDetailBuilder: ProductDetailBuilder = ProductDetailBuilder()) {
        self.navigationController = navigationController
        self.productDetailBuilder = productDetailBuilder
    }
}

extension ProductCellRouter: ProductCellRouterInput {
    func goToDetail(with product: Product, cellPresenter: ProductCellPresenter) {
        let productDetailViewController = productDetailBuilder.build(with: navigationController, product: product, cellPresenter: cellPresenter)
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
}
