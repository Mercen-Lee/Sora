import Foundation
import Alamofire

public protocol SoraService {
    
    var endpoint: URL { get }
    
    var path: [String] { get set }
    
    var interceptor: Interceptor { get }
    
    init()
    
    init(path: String...)
}

public extension SoraService {
    
    var interceptor: Interceptor { .init() }
    
    var path: [String] {
        get { .init() }
        set { }
    }
    
    init() { self.init() }
    
    init(path: String...) {
        self.init()
        self.path = path
    }
}
