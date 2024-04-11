//
//  QuantityControlBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class QuantityControlBuilder {
    func build(with navigationController: UINavigationController, orientation: StackOrientation) -> QuantityControlView {
        let interactor = QuantityControlInteractor()
        let view = QuantityControlView(stackOrientation: orientation)
        //TODO: - Product Detail builder
        let router = QuantityControlRouter(navigationController: navigationController)
        let presenter = QuantityControlPresenter(view: view, interactor: interactor, router: router) //will also add productDetailBuilder
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
}
