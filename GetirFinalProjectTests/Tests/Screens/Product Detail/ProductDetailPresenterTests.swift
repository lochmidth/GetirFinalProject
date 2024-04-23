//
//  ProductDetailPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class ProductDetailPresenterTests: XCTestCase {
    var sut: ProductDetailPresenter!
    var view: MockProductDetailViewController!
    var interactor: MockProductDetailInteractor!
    
    override func setUp() {
        super.setUp()
        view = MockProductDetailViewController()
        interactor = MockProductDetailInteractor(product: mockProduct1)
        sut = ProductDetailPresenter(view: view, interactor: interactor)
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        view = nil
    }
    
    func test_viewWillAppear() {
        sut.viewWillAppear()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(interactor.isUpdateProductCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(view.isConfigureProductDetailsCalled)
        XCTAssertTrue(view.isReloadCalled)
        XCTAssertTrue(view.isConfigureFooterSubviewsCalled)
        XCTAssertTrue(view.isConfigureNavigationBarCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_configureQuantityControl() {
        let quantityControl = sut.configureQuantityControl()
        XCTAssertNotNil(quantityControl)
    }
    
    func test_didTapAddToCartButton() {
        sut.didTapAddToCartButton()
        XCTAssertNil(sut.quantityControlPresenter)
    }
    
    func test_didUpdateProduct() {
        sut.didUpdateProduct()
        XCTAssertFalse(view.isConfigureFooterSubviewsCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_didQuantityChange() {
        sut.didQuantityChange(1)
        XCTAssertTrue(view.isConfigureFooterSubviewsCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }

}
