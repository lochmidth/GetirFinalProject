//
//  File.swift
//  
//
//  Created by Alphan Ogün on 22.04.2024.
//

import Foundation
import GetirSDK
import SwiftAsyncNetworking

enum MockError: Error {
    case someError
}

final class MockNetworkClient: NetworkClientProtocol {
    
    var isPerformRequestCalled = false
    var performRequestResult: Result<[Codable], Error>?
    func performRequest<T: Codable>(request: NetworkRequestable) async throws -> T {
        isPerformRequestCalled = true
        if let result = performRequestResult {
            switch result {
            case .success(let data):
                return data as! T
            case .failure(let error):
                throw error
            }
        } else {
            throw MockError.someError
        }
    }
}
