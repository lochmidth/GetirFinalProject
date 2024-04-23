//
//  QuantityControlPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class QuantityControlPresenterTests: XCTestCase {
    var sut: QuantityControlPresenter!
    var view: MockQuantityControlView!
    var interactor: MockQuantityControlInteractor!
    
    override func setUp() {
        super.setUp()
        view = MockQuantityControlView()
        interactor = MockQuantityControlInteractor(product: mockProduct1)
        sut = QuantityControlPresenter(interactor: interactor)
        sut.view = view
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        interactor = nil
        super.tearDown()
    }
    
    func test_didLoadQuantityControl() {
        sut.didLoadQuantityControl()
        XCTAssertTrue(view.isConfigureStackOrientationCalled)
        XCTAssertTrue(view.isUpdateWithCountCalled)
    }
    
    func test_didTapPlus() {
        sut.didTapPlus()
        XCTAssertTrue(view.isEnableButtonsCalled)
        XCTAssertTrue(interactor.isIncreaseCountCalled)
    }
    
    func test_didTapMinus() {
        sut.didTapMinus()
        XCTAssertTrue(view.isEnableButtonsCalled)
        XCTAssertTrue(interactor.isDecreaseCountCalled)
    }
    
    func test_didChangeCount() {
        sut.didChangeCount(2)
        XCTAssertTrue(view.isUpdateWithCountCalled)
        XCTAssertTrue(view.isEnableButtonsCalled)
    }
}
