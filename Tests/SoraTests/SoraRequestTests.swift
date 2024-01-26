import XCTest
import Alamofire
@testable import Sora

final class SoraTests: XCTestCase {
    
    struct TestService: SoraService {
        
        let endpoint: URL = URL(string: "https://reqres.in/api/")!
        let path: [String]
    }

    struct GetExample: SoraRequest {
        
        let service = TestService.path("users")
        let method: HTTPMethod = .get
        
        struct Body: Encodable {
            
            let name: String
            let age: Int
        }
    }

    struct PostExample: SoraRequest {
        
        let service = TestService.path("users")
        let method: HTTPMethod = .post
        
        struct Body: Encodable {
            
            let name: String
            let age: Int
        }
    }
    
    func testPostRequest() throws {
        AF.request(PostExample())
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print(String(decoding: data, as: UTF8.self))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
