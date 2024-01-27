import XCTest
import Alamofire
@testable import Sora

final class SoraTests: XCTestCase {
    
    // MARK: - Service
    struct TestService: Service {
        
        let endpoint: URL = URL(string: "https://reqres.in/api/")!
        let path: [String]
    }
    
    // MARK: - GET Request
    func testGetRequest() async throws {
        
        struct GetExample: Requestable {
            let route: TestService = .path("users")
            let method: RequestMethod = .get
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
        
        struct PostExample: Requestable, Body {
            
            let route: TestService = .path("users")
            let method: RequestMethod = .post
            
            let body: Body
            
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
    
    // MARK: - Simple Concurrency
    func testSimpleConcurrency() async throws {
        
        struct GetExample: Requestable {
            let route: TestService = .path("users")
            let method: RequestMethod = .get
        }
        
        struct Requres: Codable {
            let page, perPage, total, totalPages: Int
            let data: [Datum]
            let support: Support
        }
        
        struct Datum: Codable {
            let id: Int
            let email, firstName, lastName: String
            let avatar: String
        }
        
        struct Support: Codable {
            let url: String
            let text: String
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try! await GetExample()
            .request(decodeWith: Requres.self, decoder: decoder)
        
        XCTAssertEqual(response.total, 12, "Failure")
    }
}
