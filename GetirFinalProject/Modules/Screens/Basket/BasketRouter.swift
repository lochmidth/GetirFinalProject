//
//  BasketRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

protocol BasketRouterOutput: AnyObject {
    func didTapCheckoutButton()
    func didTapClearAllButton()
    func didTapCancelButton()
}

final class BasketRouter {
    var navigationController: UINavigationController!
    weak var presenter: BasketRouterOutput!
}

extension BasketRouter: BasketRouterInput {
    func showDidCheckoutMessage() {
        let confirmAlert = UIAlertController(title: Constants.confirmText, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.ok, style: .default) { [weak self] _ in
            guard let self = self else { return }
            dismissBasket()
        }
        confirmAlert.addAction(action)
        Task { @MainActor in
            navigationController.present(confirmAlert, animated: true)
        }
    }
    
    func showClearAllMessage() {
        let alert = UIAlertController(title: "", message: Constants.askToClearText, preferredStyle: .alert)
        let clearAction = UIAlertAction(title: Constants.yes, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapClearAllButton()
        }
        let cancelAction = UIAlertAction(title: Constants.no, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapCancelButton()
        }
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        navigationController.present(alert, animated: true)
    }
    
    func showCheckoutMessage() {
        let alert = UIAlertController(title: "", message: Constants.askForConfirmationText, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.yes, style: .default) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapCheckoutButton()
            
        }
        let cancelAction = UIAlertAction(title: Constants.no, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapCancelButton()
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        navigationController.present(alert, animated: true)
    }
    
    func dismissBasket() {
        Task { @MainActor in
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func showAlert(with error: Error) {
        let alert = UIAlertController(title: Constants.titleText, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: Constants.ok, style: .default))
        Task { @MainActor in
            navigationController.present(alert, animated: true)
        }
    }
}

extension BasketRouter {
    struct Constants {
        static let titleText = "Oops!"
        static let confirmText = "Siparişin alındı!"
        static let ok = "Tamam"
        static let askToClearText = "Sepeti temizlemek istediğinden emin misin?"
        static let yes = "Evet"
        static let no = "Hayır"
        static let askForConfirmationText = "Siparişi onaylıyor musunuz?"
    }
}
