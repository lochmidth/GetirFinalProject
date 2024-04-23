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
        let confirmAlert = UIAlertController(title: "Siparişin alındı!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default) { [weak self] _ in
            guard let self = self else { return }
            dismissBasket()
        }
        confirmAlert.addAction(action)
        Task { @MainActor in
            navigationController.present(confirmAlert, animated: true)
        }
    }
    
    func showClearAllMessage() {
        let alert = UIAlertController(title: "", message: "Sepeti temizlemek istediğinden emin misin?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Evet", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapClearAllButton()
        }
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapCancelButton()
        }
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        navigationController.present(alert, animated: true)
    }
    
    func showCheckoutMessage() {
        let alert = UIAlertController(title: "", message: "Siparişi onaylıyor musunuz?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Evet", style: .default) { [weak self] _ in
            guard let self = self else { return }
            presenter.didTapCheckoutButton()
            
        }
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel) { [weak self] _ in
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
        let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        Task { @MainActor in
            navigationController.present(alert, animated: true)
        }
    }
}
