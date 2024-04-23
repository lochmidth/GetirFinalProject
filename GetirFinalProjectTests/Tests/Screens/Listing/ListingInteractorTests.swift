//
//  ListingInteractorTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 24.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class ListingInteractorTests: XCTestCase {
    var sut: ListingInteractor!
    var presenter: MockListingPresenter!
    var getirService: MockGetirService!
    var cartService: MockCartService!
    
    override func setUp() {
        super.setUp()
        presenter = MockListingPresenter()
        getirService = MockGetirService()
        cartService = MockCartService()
        sut = ListingInteractor(getirService: getirService, cartService: cartService)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        getirService = nil
        cartService = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_updateAllProducts() {
        sut.updateAllProducts()
        XCTAssertTrue(presenter.isDidReceiveAllProductCaleld)
    }
    
    func test_fetchAllProducts() {
        sut.fetchAllProducts()
        XCTAssertFalse(presenter.isDidReceiveAllProductCaleld)
    }

}
