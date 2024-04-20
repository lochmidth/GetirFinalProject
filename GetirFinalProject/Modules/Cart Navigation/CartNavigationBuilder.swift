//
//  CartNavigationBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class CartNavigationBuilder {
    func build(with navigationController: UINavigationController) -> UIView {
        let view = CartNavigationView(frame: CGRect(x: 0, y: 0, width: 91, height: 34))
        let router = CartNavigationRouter()
        router.navigationController = navigationController
        let presenter = CartNavigationPresenter(view: view, router: router)
        view.presenter = presenter
        presenter.viewDidLoad()
        return view
    }
}
