import Alamofire

public protocol SoraRequest {
    
    associatedtype Body: Encodable
    associatedtype Service: SoraService
    
    var service: Service { get }
    var method: HTTPMethod { get }
}

public extension SoraRequest {
    
    func responseDecodable(completion: @escaping () -> Void) {
        
    }
}
