//
//  MockBasketPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockBasketPresenter: BasketViewControllerOutput {
    var section: Int?
    var indexPath: IndexPath?
    var priceText: String?
    var error: Error?
    var isDidUpdateProductListCalled = false
    var isDidClearCartCalled = false
    var isDidCheckoutCalled = false
    var isDidFailCalled = false
    var isDidTapCheckoutButtonCalled = false
    var isDidTapClearAllButtonCalled = false
    var isDidTapCancelButtonCalled = false
    
    var isViewDidLoadCalled = false
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    var isDidTapCheckoutCalled = false
    func didTapCheckout() {
        isDidTapCheckoutCalled = true
    }
    
    var isDidTapTrashButtonCalled = false
    func didTapTrashButton() {
        isDidTapTrashButtonCalled = true
    }
    
    var isNumberOfItemsInSectionCalled = false
    func numberOfItemsInSection(_ section: Int) -> Int {
        self.section = section
        isNumberOfItemsInSectionCalled = true
        return mockProducts.count
    }
    
    var isPresenterForCellCalled = false
    func presenterForCell(at indexPath: IndexPath) -> ProductCellPresenter {
        self.indexPath = indexPath
        isPresenterForCellCalled = true
        return ProductCellPresenter(product: mockProducts[indexPath.item])
    }
}

extension MockBasketPresenter: BasketInteractorOutput {
    func didUpdateProductList(withPrice priceText: String) {
        self.priceText = priceText
        isDidUpdateProductListCalled = true
    }
    
    func didClearCart() {
        isDidClearCartCalled = true
    }
    
    func didCheckout() {
        isDidCheckoutCalled = true
    }

    func didFail(with error: any Error) {
        self.error = error
        isDidFailCalled = true
    }
}

extension MockBasketPresenter: BasketRouterOutput {
    func didTapCheckoutButton() {
        isDidTapCheckoutButtonCalled = true
    }
    
    func didTapClearAllButton() {
        isDidTapClearAllButtonCalled = true
    }
    
    func didTapCancelButton() {
        isDidTapCancelButtonCalled = true
    }
}
