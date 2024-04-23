//
//  CartNavigationPresenter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import Foundation

protocol CartNavigationViewInput: AnyObject {
    func reload()
    func configureNavigationView()
    func configureObserver()
    func configureTapGesture()
}

protocol CartNavigationRouterInput: AnyObject {
    func goToBasket()
}

final class CartNavigationPresenter {
    
    weak var view: CartNavigationViewInput!
    var router: CartNavigationRouterInput
    
    init(view: CartNavigationViewInput!, router: CartNavigationRouterInput) {
        self.view = view
        self.router = router
    }
}

extension CartNavigationPresenter: CartNavigationViewOutput {
    func didTapCart() {
        router.goToBasket()
    }
    
    func viewDidLoad() {
        view.configureNavigationView()
        view.configureObserver()
        view.configureTapGesture()
        view.reload()
    }
}
