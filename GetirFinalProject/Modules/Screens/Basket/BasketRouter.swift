//
//  BasketRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class BasketRouter {
    var navigationController: UINavigationController!
    
    
}

extension BasketRouter: BasketRouterInput {
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        Task { @MainActor in
            navigationController.present(alert, animated: true)
        }
    }
}
