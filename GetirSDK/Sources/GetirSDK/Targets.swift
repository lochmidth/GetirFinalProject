import Foundation
import SwiftAsyncNetworking

public enum APIEndpoint {
    case products
    case suggestedProducts
}

extension APIEndpoint: NetworkRequestable {
    public var baseURL: String {
        return "https://65c38b5339055e7482c12050.mockapi.io/"
    }
    public var path: String {
        switch self {
        case .products:
            return "api/products"
        case .suggestedProducts:
            return "api/suggestedProducts"
        }
    }
    public var method: SwiftAsyncNetworking.HTTPMethod {
        return .get
    }
}
