//
//  BasketBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class BasketBuilder {
    func build(with navigationController: UINavigationController) -> UIViewController {
        let interactor = BasketInteractor()
        let view = BasketViewController()
        let router = BasketRouter()
        router.navigationController = navigationController
        let presenter = BasketPresenter(view: view, interactor: interactor, router: router)
        router.presenter = presenter
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
