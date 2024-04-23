//
//  QuantityControlInteractorTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class QuantityControlInteractorTests: XCTestCase {
    var sut: QuantityControlInteractor!
    var presenter: MockQuantityControlPresenter!
    var interactor: MockQuantityControlInteractor!
    var product: Product!
    var cartService: MockCartService!
    
    override func setUp() {
        super.setUp()
        cartService = MockCartService()
        product = mockProduct1
        interactor = MockQuantityControlInteractor(product: product)
        presenter = MockQuantityControlPresenter(interactor: interactor)
        sut = QuantityControlInteractor(product: product, cartService: cartService)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        interactor = nil
        product = nil
        cartService = nil
    }
    
    func test_increaseCount_thenFail() {
        cartService.addProductToCartResult = .failure(MockError.someError)
        let expectation = XCTestExpectation(description: "increaseCount Complete")
        Task {
            sut.increaseCount()
            expectation.fulfill()
        }
        wait(for: [expectation])
            XCTAssertTrue(cartService.isAddProductToCartCalled)
            XCTAssertFalse(presenter.isDidChangeCountCalled)
    }
    
    func test_decreaseCount_thenFail() {
        sut.product.quantity = 1
        cartService.addProductToCartResult = .failure(MockError.someError)
        let expectation = XCTestExpectation(description: "decreaseCount Complete")
        Task {
            sut.decreaseCount()
            expectation.fulfill()
        }
        wait(for: [expectation])
        XCTAssertTrue(cartService.isRemoveProductFromCartCalled)
        XCTAssertFalse(presenter.isDidChangeCountCalled)
    }
}
