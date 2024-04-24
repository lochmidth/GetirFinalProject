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
        let alert = UIAlertController(title: Constants.messageTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: Constants.messageOK, style: .default))
        Task { @MainActor in
            navigationController.present(alert, animated: true)
        }
    }
}

extension ListingRouter {
    struct Constants {
        static let messageTitle = "Oops!"
        static let messageOK = "OK"
    }
}
