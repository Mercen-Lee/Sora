import Alamofire

public protocol SoraRequest<Body> {
    
    associatedtype Body
    var endpoint: String { get }
    var method: HTTPMethod { get }
}
