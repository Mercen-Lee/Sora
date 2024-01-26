import XCTest
import Alamofire
@testable import Sora

struct TestService: SoraService {
    
    let endpoint: URL = URL(string: "https://example.com/")!
}

struct PostExample: SoraRequest {
    
    let service = TestService(path: "hi")
    let method: HTTPMethod = .post
    
    struct Body: Encodable {
        
        let name: String
        let age: Int
    }
}

final class SoraTests: XCTestCase {
    
    func testPostRequest() throws {
        PostExample()
            .responseDecodable {
                
            }
    }
}
