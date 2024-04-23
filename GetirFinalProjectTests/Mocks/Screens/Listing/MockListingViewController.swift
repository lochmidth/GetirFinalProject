//
//  MockListingViewController.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockListingViewController: ListingViewControllerInput {
    
    var isConfigureNavigationBarCalled = false
    func configureNavigationBar() {
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
    func reload() {
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
