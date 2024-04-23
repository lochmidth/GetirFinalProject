import XCTest
@testable import SwiftAsyncNetworking

final class SwiftAsyncNetworkingTests: XCTestCase {
    var sut: NetworkClient!
    
    override func setUp() {
        super.setUp()
        sut = NetworkClient()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_performRequest_thenSuccess() async {
        let mockRequest = SampleRequestSuccess()
        do {
            let data: [MockProductListDTO] = try await sut.performRequest(request: mockRequest)
            XCTAssertNotNil(data)
        } catch {
            XCTFail()
        }
    }
    func test_performRequest_thenFail() async {
        let request = SampleRequestFailure()
        do {
            let _: [MockProductListDTO] = try await sut.performRequest(request: request)
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

