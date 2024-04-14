//
//  ListingRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 10.04.2024.
//

import UIKit

final class ListingRouter {
    var navigationController: UINavigationController!
    
}

extension ListingRouter: ListingRouterInput {
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        Task { @MainActor in
            navigationController.present(alert, animated: true)
        }
    }
}
