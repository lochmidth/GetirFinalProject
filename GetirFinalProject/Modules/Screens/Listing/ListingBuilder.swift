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
        let productCellBuilder = ProductCellBuilder()
        let router = ListingRouter()
        let navigationController = UINavigationController(rootViewController: view)
        router.navigationController = navigationController
        let presenter = ListingPresenter(view: view, interactor: interactor, router: router, productCellBuilder: productCellBuilder)
        view.presenter = presenter
        interactor.presenter = presenter
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .getirPurple
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.scrollEdgeAppearance = apperance
        navigationController.navigationBar.standardAppearance = apperance
        return navigationController
    }
}
