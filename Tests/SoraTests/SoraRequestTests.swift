import XCTest
import Alamofire
@testable import Sora

final class SoraTests: XCTestCase {
    
    // MARK: - SoraService
    struct TestService: SoraService {
        
        let endpoint: URL = URL(string: "https://reqres.in/api/")!
        let path: [String]
    }
    
    // MARK: - GET Request
    func testGetRequest() async throws {
        
        struct GetExample: SoraRequest {
            let service: TestService = .path("users")
            let method: SoraMethod = .get
        }
        
        let response = await AF.request(GetExample())
            .validate()
            .serializingDecodable(Empty.self)
            .response
        if case let .failure(error) = response.result {
            throw error
        }
        XCTAssertEqual(response.response?.statusCode, 200, "Failure")
    }
    
    // MARK: - POST Request
    func testPostRequest() async throws {
        
        struct PostExample: SoraRequest {
            
            let service: TestService = .path("users")
            let method: SoraMethod = .post
            
            let body: Body?
            
            struct Body: Encodable {
                
                let name: String
                let job: String
            }
        }
        
        let request = PostExample(body: .init(name: "morpheus", job: "leader"))
        let response = await AF.request(request)
            .validate()
            .serializingDecodable(Empty.self)
            .response
        if case let .failure(error) = response.result {
            throw error
        }
        XCTAssertEqual(response.response?.statusCode, 201, "Failure")
    }
}
