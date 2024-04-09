import Foundation
import SwiftAsyncNetworking

public class GetirSDK {
    private let networkClient: NetworkClient
    
    public init() {
        self.networkClient = NetworkClient()
    }
    
    /// Fetches Products from given mock product url
    public func fetchProducts() async throws -> ProductListDTO {
        let request = APIEndpoint.products
        let data: [ProductListDTO] = try await networkClient.performRequest(request: request)
        return data[0]
    }
    
    /// Fetches Suggested products from given mock suggestedProduct url
    public func fetchSuggestedProducts() async throws -> SuggestedProductListDTO {
        let request = APIEndpoint.suggestedProducts
        let data: [SuggestedProductListDTO] = try await networkClient.performRequest(request: request)
        return data[0]
    }
}
