//
//  ProductDetailInteractorTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class ProductDetailInteractorTests: XCTestCase {
    var sut: ProductDetailInteractor!
    var presenter: MockProductDetailPresenter!
    var product: Product!
    var cartService: MockCartService!
    
    override func setUp() {
        super.setUp()
        presenter = MockProductDetailPresenter()
        product = mockProduct1
        cartService = MockCartService()
        sut = ProductDetailInteractor(product: product, cartService: cartService)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        product = nil
        cartService = nil
    }
    
    func test_updateProduct() {
        sut.updateProduct()
        XCTAssertNotNil(sut.product)
    }

}
