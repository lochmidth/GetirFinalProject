//
//  MockCartNavigationRouter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockCartNavigationRouter: CartNavigationRouterInput {
    var isGoToBasketCalled = false
    func goToBasket() {
        isGoToBasketCalled = true
    }
}
