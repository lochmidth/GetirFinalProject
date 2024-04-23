//
//  ProductCellPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class ProductCellPresenterTests: XCTestCase {
    var sut: ProductCellPresenter!
    var view: MockProductCellView!
    var router: MockProductCellRouter!
    var product: Product!
    
    override func setUp() {
        super.setUp()
        view = MockProductCellView()
        router = MockProductCellRouter()
        product = mockProduct1
        sut = ProductCellPresenter(product: product)
        sut.router = router
        sut.view = view
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        router = nil
        product = nil
    }
    
    func test_didLoadCell() {
        sut.didLoadCell()
        XCTAssertTrue(view.isConfigureStackCalled)
        XCTAssertTrue(view.isConfigureQuantityControlCalled)
        XCTAssertTrue(view.isUpdateWithProductCalled)
        XCTAssertEqual(view.product?.id, mockProduct1.id)
    }
    
    func test_didTapCell() {
        sut.didTapCell()
        XCTAssertTrue(router.isGoToDetailCalled)
    }
    
    func test_didQuantityChange() {
        sut.didQuantityChange(sut.product.quantity + 1)
        XCTAssertTrue(view.isUpdateWithCountCalled)
    }

}
