//
//  MockProductDetailPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductDetailPresenter: ProductDetailViewControllerOutput {
    
    var isViewDidLoadCalled = false
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    var isViewWillAppearCalled = false
    func viewWillAppear() {
        isViewWillAppearCalled = true
    }
    
    var isConfigureQuantityControlCalled = false
    func configureQuantityControl() -> GetirFinalProject.QuantityControlView {
        isConfigureQuantityControlCalled = true
        return QuantityControlView(presenter: MockQuantityControlPresenter(interactor: MockQuantityControlInteractor(product: mockProduct1)), stackOrientation: .horizontal)
    }
    
    var isDidTapAddToCartButtonCalled = false
    func didTapAddToCartButton() {
        isDidTapAddToCartButtonCalled = true
    }
}

extension MockProductDetailPresenter: ProductDetailInteractorOutput {
    
}
