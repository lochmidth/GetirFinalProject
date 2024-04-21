//
//  ProductDetailBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 15.04.2024.
//

import UIKit

final class ProductDetailBuilder {
    func build(with product: Product) -> UIViewController {
        let interactor = ProductDetailInteractor(product: product)
        let view = ProductDetailViewController()
        let presenter = ProductDetailPresenter(view: view, interactor: interactor)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
