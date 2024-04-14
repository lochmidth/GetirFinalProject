import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol NetworkRequestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var headers: [String: String]? { get }
}

extension NetworkRequestable {
    public var parameters: Encodable? {
        nil
    }
    
    public var headers: [String: String]? {
        nil
    }
}


