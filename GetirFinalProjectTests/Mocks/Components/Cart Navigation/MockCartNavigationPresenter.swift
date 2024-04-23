//
//  MockCartNavigationPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockCartNavigationPresenter: CartNavigationViewOutput {
    
    var isViewDidLoadCalled = false
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    var isDidTapCartCalled = false
    func didTapCart() {
        isDidTapCartCalled = true
    }
}
