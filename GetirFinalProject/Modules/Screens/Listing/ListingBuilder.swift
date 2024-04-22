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
        let view = ListingViewController()
        let router = ListingRouter()
        let navigationController = CustomNavigationController(rootViewController: view)
        router.navigationController = navigationController
        let presenter = ListingPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return navigationController
    }
}
