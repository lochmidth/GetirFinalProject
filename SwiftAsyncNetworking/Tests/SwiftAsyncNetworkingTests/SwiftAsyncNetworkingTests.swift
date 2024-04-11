import XCTest
@testable import SwiftAsyncNetworking

final class SwiftAsyncNetworkingTests: XCTestCase {
    func test_performRequest_thenSuccess() async {
        let network = NetworkClient()
        let request = SampleRequestSuccess()
        
        do {
            let data = try await network.performRequest(request: request)
            
            XCTAssertNotNil(data)
        } catch {
            XCTFail("Unexpected error, \(error.localizedDescription)")
        }
    }
//    func test_performRequest_thenFail() async {
//        let network = NetworkClient()
//        let request = SampleRequestFailure()
//        
//        do {
//            let data = try await network.performRequest(request: request)
//            
//            XCTAssertNil(data)
//        } catch {
//            XCTAssertNotNil(error)
//        }
//    }
}
