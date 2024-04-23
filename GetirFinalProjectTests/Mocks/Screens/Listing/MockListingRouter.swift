//
//  MockListingRouter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import UIKit
@testable import GetirFinalProject

final class MockListingRouter: ListingRouterInput {
    var navigationController: UINavigationController!
    var error: Error?
    
    var isShowAlertCalled = false
    func showAlert(with error: any Error) {
        self.error = error
        isShowAlertCalled = true
    }
}
