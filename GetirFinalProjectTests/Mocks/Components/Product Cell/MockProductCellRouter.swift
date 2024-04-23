//
//  MockProductCellRouter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductCellRouter: ProductCellRouterInput {
    var product: Product?
    var cellPresenter: ProductCellPresenter?
    
    var isGoToDetailCalled = false
    func goToDetail(with product: Product, cellPresenter: ProductCellPresenter) {
        self.product = product
        self.cellPresenter = cellPresenter
        isGoToDetailCalled = true
    }
}
