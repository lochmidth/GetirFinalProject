//
//  MockCoreDataManager.swift
//  GetirFinalProjectTests
//
//  Created by Alphan Ogün on 23.04.2024.
//

import Foundation
@testable import GetirFinalProject

enum MockError: Error {
    case someError
}

final class MockCoreDataManager: CoreDataManagerProtocol {
    
    var isAddToCoreDataCalled = false
    var addToCoreDataResult: Result<Void, Error>?
    func addToCoreData(forProduct product: Product) async throws {
        isAddToCoreDataCalled = true
        if let result = addToCoreDataResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isUpdateProductQuantityCalled = false
    var updateProductQuantityResult: Result<Void, Error>?
    func updateProductQuantity(id: String, newQuantity: Int) async throws {
        isUpdateProductQuantityCalled = true
        if let result = updateProductQuantityResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isFetchAllCoreDataCalled = false
    var fetchAllCoreDataResult: Result<[(id: String, quantity: Int)], Error>?
    func fetchAllCoreData() async throws -> [(id: String, quantity: Int)] {
        isFetchAllCoreDataCalled = true
        if let result = fetchAllCoreDataResult {
            switch result {
            case .success(let idsAndQuantities):
                return idsAndQuantities
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isDeleteCoreDataForProductCalled = false
    var deleteCoreDataForProductResult: Result<Void, Error>?
    func deleteCoreData(forProduct product: Product) async throws {
        isDeleteCoreDataForProductCalled = true
        if let result = deleteCoreDataForProductResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
    
    var isDeleteAllDataCalled = false
    var deleteAllDataResult: Result<Void, Error>?
    func deleteAllData() async throws {
        isDeleteAllDataCalled = true
        if let result = deleteAllDataResult {
            switch result {
            case .success():
                return
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
}
