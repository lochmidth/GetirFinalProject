//
//  ListingBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

final class ListingBuilder {
    func build() -> CustomNavigationController {
        let interactor = ListingInteractor()
        let view = ListingViewController()
        let productCellBuilder = ProductCellBuilder()
        let router = ListingRouter()
        let navigationController = CustomNavigationController(rootViewController: view)
        router.navigationController = navigationController
        let presenter = ListingPresenter(view: view, interactor: interactor, router: router, productCellBuilder: productCellBuilder)
        view.presenter = presenter
        interactor.presenter = presenter
        return navigationController
    }
}
