//
//  QuantityControlBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class QuantityControlBuilder {
    func build(with prodcut: Product) -> QuantityControlPresenter {
        let interactor = QuantityControlInteractor(product: prodcut)
        let presenter = QuantityControlPresenter(interactor: interactor)
        interactor.presenter = presenter
        return presenter
    }
}
