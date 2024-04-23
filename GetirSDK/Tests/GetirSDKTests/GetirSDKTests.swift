import XCTest
@testable import GetirSDK

final class GetirSDKTests: XCTestCase {
    var sut: GetirSDK!
    var networkClient: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        networkClient = MockNetworkClient()
        sut = GetirSDK(networkClient: networkClient)
    }
    
    override func tearDown() {
        sut = nil
        networkClient = nil
        super.tearDown()
    }
    
    func test_fetchProducts_thenSuccess() async {
        //GIVEN
        networkClient.performRequestResult = .success([ProductListDTO]())
        //WHEN
        do {
            let products = try await sut.fetchProducts()
            //THEN
            XCTAssertEqual(products.id, "")
        } catch {
        }
    }
    
    func test_fetchProducts_thenFail() async {
        //GIVEN
        networkClient.performRequestResult = .failure(MockError.someError)
        //WHEN
        do {
            _ = try await sut.fetchProducts()
            //THEN
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchSuggestedProducts_thenSuccess() async {
        //GIVEN
        networkClient.performRequestResult = .success([SuggestedProductListDTO]())
        //WHEN
        do {
            let products = try await sut.fetchSuggestedProducts()
            //THEN
            XCTAssertEqual(products.id, "")
        } catch {
        }
    }
    
    func test_fetchSuggestedProducts_thenFail() async {
        //GIVEN
        networkClient.performRequestResult = .failure(MockError.someError)
        //WHEN
        do {
            let _ = try await sut.fetchSuggestedProducts()
            //THEN
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
