//
//  MockBasketViewController.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockBasketViewController: BasketViewControllerInput {
    var priceText: String?
    
    var isConfigureNavigationBarCalled = false
    func configureNavigationbar() {
        isConfigureNavigationBarCalled = true
    }
    
    var isConfigureCollectionViewCalled = false
    func configureCollectionView() {
        isConfigureCollectionViewCalled = true
    }
    
    var isConfigureSubviewsCalled = false
    func configureSubviews() {
        isConfigureSubviewsCalled = true
    }
    
    var isReloadCalled = false
    func reload(withPrice priceText: String) {
        self.priceText = priceText
        isReloadCalled = true
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
