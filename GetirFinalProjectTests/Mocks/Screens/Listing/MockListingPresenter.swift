//
//  MockListingPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockListingPresenter: ListingViewControllerOutput {
    var section: Int?
    var indexPath: IndexPath?
    var error: Error?
    var isDidReceiveAllProductCaleld = false
    var isDidFailCalled = false
    
    var isViewDidLoadCalled = false
    func viewDidLoad() {
        isViewDidLoadCalled = true
    }
    
    var isViewWillAppearCalled = false
    func viewWillAppear() {
        isViewWillAppearCalled = true
    }
    
    var isNumberOfItemsInSectionCalled = false
    func numberOfItemsInSection(_ section: Int) -> Int {
        self.section = section
        isNumberOfItemsInSectionCalled = true
        return mockProducts.count
    }
    
    var isPresenterForCellCalled = false
    func presenterForCell(at indexPath: IndexPath) -> GetirFinalProject.ProductCellPresenter {
        self.indexPath = indexPath
        isPresenterForCellCalled = true
        return ProductCellPresenter(product: mockProducts[indexPath.item])
    }
}

extension MockListingPresenter: ListingInteractorOutput {
    func didReceiveAllProducts() {
        isDidReceiveAllProductCaleld = true
    }
    
    func didFail(with error: any Error) {
        self.error = error
        isDidFailCalled = true
    }
}
