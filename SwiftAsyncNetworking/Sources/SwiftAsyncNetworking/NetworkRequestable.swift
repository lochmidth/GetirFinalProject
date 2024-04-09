import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

public protocol NetworkRequestable {
  var baseURL: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
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


