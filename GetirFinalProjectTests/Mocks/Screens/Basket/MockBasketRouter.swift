//
//  MockBasketRouter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import UIKit
@testable import GetirFinalProject

final class MockBasketRouter: BasketRouterInput {
    var navigationController: UINavigationController!
    var error: Error?
    
    var isDismissBasketCalled = false
    func dismissBasket() {
        isDismissBasketCalled = true
    }
    
    var isShowCheckoutMessageCalled = false
    func showCheckoutMessage() {
        isShowCheckoutMessageCalled = true
    }
    
    var isShowClearAllMessageCalled = false
    func showClearAllMessage() {
        isShowClearAllMessageCalled = true
    }
    
    var isShowDidCheakoutMessageCalled = false
    func showDidCheckoutMessage() {
        isShowDidCheakoutMessageCalled = true
    }
    
    var isShowAlertCalled = false
    func showAlert(with error: any Error) {
        self.error = error
        isShowAlertCalled = true
    }
    
    
}
