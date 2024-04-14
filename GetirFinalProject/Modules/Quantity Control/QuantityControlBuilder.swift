//
//  QuantityControlBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 11.04.2024.
//

import UIKit

final class QuantityControlBuilder {
    func build(with orientation: StackOrientation) -> QuantityControlPresenter {
        let interactor = QuantityControlInteractor()
//        let router = QuantityControlRouter() 
        let presenter = QuantityControlPresenter(interactor: interactor)
        interactor.presenter = presenter
        return presenter
    }
}
