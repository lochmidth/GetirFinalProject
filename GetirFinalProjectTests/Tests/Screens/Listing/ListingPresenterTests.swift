//
//  ListingPresenterTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class ListingPresenterTests: XCTestCase {
    var sut: ListingPresenter!
    var view: MockListingViewController!
    var interactor: MockListingInteractor!
    var router: MockListingRouter!
    
    override func setUp() {
        super.setUp()
        view = MockListingViewController()
        interactor = MockListingInteractor()
        router = MockListingRouter()
        sut = ListingPresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        sut = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    func test_viewWillAppear() {
        sut.viewWillAppear()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(interactor.isUpdateAllProductsCalled)
    }
    
    func test_numberOfItemsInSection_given0() {
        let number = sut.numberOfItemsInSection(0)
        XCTAssertEqual(number, 0)
    }
    
    func test_numberOfItemsInSection_given1() {
        let number = sut.numberOfItemsInSection(1)
        XCTAssertEqual(number, 0)
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.isShowLoadingCalled)
        XCTAssertTrue(view.isConfigureCollectionViewCalled)
        XCTAssertTrue(view.isConfigureNavigationBarCalled)
        XCTAssertTrue(view.isConfigureSubviewsCalled)
        XCTAssertTrue(interactor.isFecthAllProductsCalled)
    }
    
    func test_didReceiveAllProduct() {
        sut.didReceiveAllProducts()
        XCTAssertTrue(view.isReloadCalled)
        XCTAssertTrue(view.isHideLoadingCalled)
    }
    
    func test_didFail() {
        sut.didFail(with: MockError.someError)
        XCTAssertTrue(view.isHideLoadingCalled)
        XCTAssertTrue(router.isShowAlertCalled)
    }

}
