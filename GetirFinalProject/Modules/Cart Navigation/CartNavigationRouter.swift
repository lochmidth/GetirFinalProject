//
//  CartNavigationRouter.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 18.04.2024.
//

import UIKit

final class CartNavigationRouter {
    var navigationController: UINavigationController!
    let basketBuilder: BasketBuilder
    
    init(basketBuilder: BasketBuilder = BasketBuilder()) {
        self.basketBuilder = basketBuilder
    }
    
}

extension CartNavigationRouter: CartNavigationRouterInput {
    func goToBasket() {
        print("Handle Go to Basket")
        let basketViewController = basketBuilder.build(with: navigationController)
        navigationController.pushViewController(basketViewController, animated: true)
    }
}
