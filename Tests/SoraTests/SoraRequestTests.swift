import XCTest
import Alamofire
@testable import Sora

final class SoraTests: XCTestCase {
    
    struct TestService: SoraService {
        
        let endpoint: URL = URL(string: "https://reqres.in/api/")!
        let path: [String]
    }

    struct GetExample: SoraRequest {
        
        let service: TestService = .path("users")
        let method: SoraMethod = .get
        
        let body: Body
        
        struct Body: Encodable {
            
            let name: String
            let age: Int
        }
    }

    struct PostExample: SoraRequest {
        
        let service = TestService.path("users")
        let method: SoraMethod = .post
        
        let body: Body
        
        struct Body: Encodable {
            
            let name: String
            let job: String
        }
    }
    
    func testPostRequest() async throws {
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
