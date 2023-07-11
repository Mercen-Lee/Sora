import Foundation

@available(macOS 10, iOS 13, tvOS 13, watchOS 6, *)
public class Session {
    
    public typealias Param = [String: Any]
    public typealias Header = [String: String]
    
    private func request(method: String,
                         url: String,
                         headers: Header?,
                         params: Param?) throws
    {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if let headers = headers {
                Array(headers.keys).forEach { key in
                    request.setValue(headers[key], forHTTPHeaderField: key)
                }
            }
            if let params = params {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            }
        }
    }
}

extension Session {
    public func get(_ url: String, headers: Header? = nil, params: Param? = nil) throws {
        try request(method: "GET", url: url, headers: headers, params: params)
    }
    
    public func post(_ url: String, headers: Header? = nil, params: Param? = nil) throws {
        try request(method: "POST", url: url, headers: headers, params: params)
    }
    
    public func patch(_ url: String, headers: Header? = nil, params: Param? = nil) throws {
        try request(method: "PATCH", url: url, headers: headers, params: params)
    }
    
    public func put(_ url: String, headers: Header? = nil, params: Param? = nil) throws {
        try request(method: "PUT", url: url, headers: headers, params: params)
    }
    
    public func delete(_ url: String, headers: Header? = nil, params: Param? = nil) throws {
        try request(method: "DELETE", url: url, headers: headers, params: params)
    }
}
