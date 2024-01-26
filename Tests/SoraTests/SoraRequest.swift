import XCTest
import Alamofire
@testable import Sora

struct PostExample: SoraRequest {
    
    let endpoint: String = "sample"
    let method: HTTPMethod = .post
    
    struct Body: Codable {
        
        let name: String
        let age: Int
    }
}

final class SoraTests: XCTestCase {
    
    func testPostRequest() throws {
        
    }
}
