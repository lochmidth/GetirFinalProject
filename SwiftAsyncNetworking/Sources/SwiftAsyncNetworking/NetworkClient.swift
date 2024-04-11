//
//  NetworkClient.swift
//
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
}

public class NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init() {
        self.session = URLSession(configuration: .default)
        self.decoder = JSONDecoder()
    }
    
    /// Uses Concurrency (async/await)
    public func performRequest<T: Codable>(request: NetworkRequestable) async throws -> T {
        guard let url = URL(string: request.baseURL + request.path) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if let parameters = request.parameters {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                throw error
            }
        }
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        do {
            let (data, _) = try await session.data(for: urlRequest)
            let dataModel = try decoder.decode(T.self, from: data)
            return dataModel
        } catch {
            throw error
        }
    }
}


