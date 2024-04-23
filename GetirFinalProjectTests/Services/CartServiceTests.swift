//
//  CartServiceTests.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import XCTest
@testable import GetirFinalProject

final class CartServiceTests: XCTestCase {
    var sut: CartService!
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = MockCoreDataManager()
        sut = CartService(coreDataManager: coreDataManager)
    }
    
    override func tearDown() {
        sut = nil
        coreDataManager = nil
    }
    
    func test_updateQuantityForProducts_thenSuccessWithProducts() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        //WHEN
        do {
            let products = try await sut.updateQuantity(for: mockProducts)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertEqual(products.count, 2)
        } catch {
        }
    }
    
    func test_updateQuantityForProducts_ThenFail() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .failure(MockError.someError)
        //WHEN
        do {
            let products = try await sut.updateQuantity(for: mockProducts)
            //THEN
            XCTFail()
        } catch {
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertFalse(coreDataManager.isUpdateProductQuantityCalled)
        }
    }
    
    func test_updateQuantityForProductCellPresenter_addToCartFalse_thenSuccess() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        //WHEN
        do {
            let cellPresenters =  try await sut.updateQuantity(for: [ProductCellPresenter(product: mockProduct1)], addCart: false)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertEqual(cellPresenters[0].product.id, mockProduct1.id)
        } catch {
        }
    }
    
    func test_updateQuantityForProductCellPresenter_addToCartTrue_thenSuccess() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        //WHEN
        do {
            let cellPresenters =  try await sut.updateQuantity(for: [ProductCellPresenter(product: mockProduct1)], addCart: true)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertEqual(cellPresenters[0].product.id, mockProduct1.id)
        } catch {
        }
    }
    
    func test_updateQuantityForProductCellPresenter_thenFail() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .failure(MockError.someError)
        //WHEN
        do {
            let cellPresenters =  try await sut.updateQuantity(for: [ProductCellPresenter(product: mockProduct1)], addCart: false)
            //THEN
            XCTAssertNil(cellPresenters)
        } catch {
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertEqual(error as! MockError, MockError.someError)
        }
    }
    
    func test_addProductToCart_thenSuccess() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        coreDataManager.addToCoreDataResult = .success(())
        coreDataManager.updateProductQuantityResult = .success(())
        var mockProduct = mockProduct1
        sut.products.append(mockProduct)
        //WHEN
        do {
            try await sut.addProductToCart(mockProduct1)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
            XCTAssertTrue(coreDataManager.isUpdateProductQuantityCalled)
        } catch {
        }
    }
    
    func test_addProductToCart_thenFail() async throws {
        //GIVEN
        coreDataManager.addToCoreDataResult = .failure(MockError.someError)
        //WHEN
        do {
            try await sut.addProductToCart(mockProduct1)
            //THEN
        } catch {
            XCTAssertFalse(coreDataManager.isAddToCoreDataCalled)
            XCTAssertEqual(error as! MockError, MockError.someError)
        }
    }
    
    func test_removeProductFromCartWithQuantity1_thenSuccess() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        coreDataManager.updateProductQuantityResult = .success(())
        var mockProduct = mockProduct1
        sut.products.append(mockProduct)
        //WHEN
        do {
            try await sut.removeProductFromCart(mockProduct1)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
        } catch {
        }
    }
    
    func test_removeProductFromCartWithQuantity2_thenSuccess() async throws {
        //GIVEN
        coreDataManager.fetchAllCoreDataResult = .success([("1",1),("2",2)])
        coreDataManager.updateProductQuantityResult = .success(())
        var mockProduct = mockProduct1
        mockProduct.quantity = 2
        sut.products.append(mockProduct)
        //WHEN
        do {
            try await sut.removeProductFromCart(mockProduct1)
            //THEN
            XCTAssertTrue(coreDataManager.isFetchAllCoreDataCalled)
        } catch {
        }
    }
    
    func test_removeAllProductsFromCart_thenSuccess() async throws {
        //GIVEN
        coreDataManager.deleteAllDataResult = .success(())
        sut.products.append(mockProduct1)
        //WHEN
        do {
            try await sut.removeAllProductsFromCart()
            //THEN
            XCTAssertTrue(coreDataManager.isDeleteAllDataCalled)
            XCTAssertEqual(sut.products.count, 0)
        }
    }
    
    func test_removeAllProductsFromCart_thenFail() async throws {
        //GIVEN
        coreDataManager.deleteAllDataResult = .failure(MockError.someError)
        sut.products.append(mockProduct1)
        //WHEN
        do {
            try await sut.removeAllProductsFromCart()
            //THEN
        } catch {
            XCTAssertTrue(coreDataManager.isDeleteAllDataCalled)
            XCTAssertNotNil(sut.products)
        }
    }
    
    func test_checkoutIfCartIsNotEmpty_thenSuccess() async throws {
        //GIVEN
        coreDataManager.deleteAllDataResult = .success(())
        sut.products.append(mockProduct1)
        //WHEN
        do {
            let status = try await sut.checkout()
            //THEN
            XCTAssertTrue(coreDataManager.isDeleteAllDataCalled)
            XCTAssertTrue(status)
        } catch {
        }
    }
    
    func test_checkoutIfCartIsNotEmpty_thenFail() async throws {
        //GIVEN
        coreDataManager.deleteAllDataResult = .failure(MockError.someError)
        sut.products.append(mockProduct1)
        //WHEN
        do {
            let status = try await sut.checkout()
            //THEN
        } catch {
            XCTAssertEqual(error as! MockError, MockError.someError)
        }
    }
    
    func test_checkoutIfCartIsEmpty_thenSuccess() async throws {
        //GIVEN
        coreDataManager.deleteAllDataResult = .success(())
        //WHEN
        do {
            let status = try await sut.checkout()
            XCTAssertFalse(coreDataManager.isDeleteAllDataCalled)
            XCTAssertFalse(status)
        } catch {
        }
    }

}
