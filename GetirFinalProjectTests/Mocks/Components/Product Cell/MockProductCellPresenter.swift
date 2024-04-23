//
//  MockProductCellPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockProductCellPresenter: ProductCellViewOutput {
    var quantityControlPresenter: QuantityControlPresenter?
    
    var isDidTapCellCalled = false
    func didTapCell() {
        isDidTapCellCalled = true
    }
    
    var isDidLoadCellCalled = false
    func didLoadCell() {
        isDidLoadCellCalled = true
    }
}
