//
//  MockQuantityControlPresenter.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

final class MockQuantityControlPresenter: QuantityControlViewOutput {
    var cellPresenterDelegate: (any QuantityControlDelegate)?
    var count: Int?
    var isDidChangeCountCalled = false
    
    var interactor: any QuantityControlInteractorInput
    
    init(interactor: any QuantityControlInteractorInput) {
        self.interactor = interactor
    }
    
    var isDidLoadQuantityControlCalled = false
    func didLoadQuantityControl() {
        isDidLoadQuantityControlCalled = true
    }
    
    var isDidTapPlusCalled = false
    func didTapPlus() {
        isDidTapPlusCalled = true
    }
    
    var isDidTapMinusCalled = false
    func didTapMinus() {
        isDidTapMinusCalled = true
    }
}

extension MockQuantityControlPresenter: QuantityControlInteractorOutput {
    func didChangeCount(_ count: Int) {
        self.count = count
        isDidChangeCountCalled = true
    }
}
