//
//  CartNavigationPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class CartNavigationPresenterTests: XCTestCase {
    var sut: CartNavigationPresenter!
    var view: MockCartNavigationView!
    var router: MockCartNavigationRouter!
    
    override func setUp() {
        super.setUp()
        view = MockCartNavigationView()
        router = MockCartNavigationRouter()
        sut = CartNavigationPresenter(view: view, router: router)
    }
    
    override func tearDown() {
        sut = nil
        router = nil
        view = nil
        super.tearDown()
    }
    
    func test_didTapCart() {
        sut.didTapCart()
        XCTAssertTrue(router.isGoToBasketCalled)
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.isConfigureNavigationViewCalled)
        XCTAssertTrue(view.isConfigureObserverCalled)
        XCTAssertTrue(view.isConfigureTapGestureCalled)
        XCTAssertTrue(view.isReloadCalled)
    }

}
