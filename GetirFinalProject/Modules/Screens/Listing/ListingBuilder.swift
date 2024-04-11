//
//  ListingBuilder.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

final class ListingBuilder {
    func build() -> UINavigationController {
        let interactor = ListingInteractor()
        let view = ListingView()
        let controller = ListingViewController(listingView: view)
        let productCellBuilder = ProductCellBuilder()
        let router = ListingRouter(productCellBuilder: productCellBuilder)
        let navigationController = UINavigationController(rootViewController: controller)
        router.navigationController = navigationController
        let presenter = ListingPresenter(controller: controller, interactor: interactor, router: router)
        controller.presenter = presenter
        interactor.presenter = presenter
        controller.input = view
        return navigationController
    }
}
