//
//  ProductDetailBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import UIKit

final class ProductDetailBuilder {
    func build(with navigationController: UINavigationController, product: Product, cellPresenter: ProductCellPresenter) -> UIViewController {
        let interactor = ProductDetailInteractor(product: product)
        let view = ProductDetailViewController()
        let router = ProductDetailRouter()
        router.navigationController = navigationController
        let presenter = ProductDetailPresenter(view: view, interactor: interactor, router: router, cellPresenter: cellPresenter)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
