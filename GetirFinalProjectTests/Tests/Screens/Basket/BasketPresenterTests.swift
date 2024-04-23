//
//  BasketPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class BasketPresenterTests: XCTestCase {
    var sut: BasketPresenter!
    var view: MockBasketViewController!
    var interactor: MockBasketInteractor!
    var router: MockBasketRouter!
    
    override func setUp() {
        super.setUp()
        view = MockBasketViewController()
        interactor = MockBasketInteractor()
        router = MockBasketRouter()
        sut = BasketPresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.isConfigureNavigationBarCalled)
        XCTAssertTrue(view.isConfigureCollectionViewCalled)
        XCTAssertTrue(view.isConfigureSubviewsCalled)
        XCTAssertTrue(interactor.isFetchProductsCalled)
    }
    
    func test_didTapCheckout() {
        sut.didTapCheckout()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(router.isShowCheckoutMessageCalled)
    }
    
    func test_didTapTrashButton() {
        sut.didTapTrashButton()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(router.isShowClearAllMessageCalled)
    }
    
    func test_numberOfItemsInSection0() {
        let number = sut.numberOfItemsInSection(0)
        XCTAssertNotNil(interactor.productList)
    }
    
    func test_numberOfItemsInSection1() {
        let number = sut.numberOfItemsInSection(1)
        XCTAssertNotNil(interactor.suggestedProductList)
    }
    
    func test_didCheckout() {
        sut.didCheckout()
        XCTAssertTrue(router.isShowDidCheakoutMessageCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_didUpdateProductList() {
        sut.didUpdateProductList(withPrice: mockProduct1.priceText)
        XCTAssertTrue(view.isReloadCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_didClearCart() {
        sut.didClearCart()
        XCTAssertTrue(router.isDismissBasketCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_didFail() {
        sut.didFail(with: MockError.someError)
        XCTAssertTrue(view.isHideLoadingCalled)
        XCTAssertTrue(router.isShowAlertCalled)
    }
    
    func test_didTapClearAllButton() {
        sut.didTapClearAllButton()
        XCTAssertTrue(interactor.isHandleClearAllProductsCalled)
    }
    
    func test_didTapCancelButton() {
        sut.didTapCancelButton()
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_dşdTapCheckoutButton() {
        sut.didTapCheckoutButton()
        XCTAssertTrue(interactor.isCheckoutCalled)
    }
    
    func test_didQuantityCange() {
        sut.didQuantityChange(for: mockProduct1)
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(interactor.isAdjustCartCalled)
    }
}
