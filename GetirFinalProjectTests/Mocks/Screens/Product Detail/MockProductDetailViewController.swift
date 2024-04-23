//
//  MockProductDetailViewController.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductDetailViewController: ProductDetailViewControllerInput {
    var quantityControl: QuantityControlView?
    var product: Product?
    var count: Int?
    
    var isConfigureProductDetailsCalled = false
    func configureProductDetails(with product: Product) {
        self.product = product
        isConfigureProductDetailsCalled = true
    }
    
    var isReloadCalled = false
    func reload(with product: Product) {
        self.product = product
        isReloadCalled = true
    }
    
    var isConfigureFooterSubviewsCalled = false
    func configureFooterSubviews(count: Int) {
        self.count = count
        if count != 0 {
            quantityControl = QuantityControlView(presenter: MockQuantityControlPresenter(interactor: MockQuantityControlInteractor(product: mockProduct1)), stackOrientation: .horizontal)
        }
        isConfigureFooterSubviewsCalled = true
    }
    
    var isConfigureNavigaitonBarCalled = false
    func configureNavigationBar() {
        isConfigureNavigaitonBarCalled = true
    }
    
    var isShowLoadingCalled = false
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    var isHideLoadingCalled = false
    func hideLoading() {
        isHideLoadingCalled = true
    }
}
