import Foundation

@available(macOS 10, iOS 13, tvOS 13, watchOS 6, *)
public class Session {
    
    private func request(_ url: String,
                 method: String)
    {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
    }
}

extension Session {
    public func get(_ url: String) {
        request(url, method: "GET")
    }
    
    public func post(_ url: String) {
        request(url, method: "POST")
    }
    
    public func patch(_ url: String) {
        request(url, method: "PATCH")
    }
    
    public func put(_ url: String) {
        request(url, method: "PUT")
    }
    
    public func delete(_ url: String) {
        request(url, method: "DELETE")
    }
}
