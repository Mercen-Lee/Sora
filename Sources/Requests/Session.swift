import Foundation

public let Requests = RequestSession()

@available(macOS 10, iOS 13, tvOS 13, watchOS 6, *)
public class RequestSession {
    public func get(_ url: String,
                    headers: [String: String]? = nil,
                    params: [String: Any]? = nil) -> Request
    {
        return Request(method: "GET", url: url, headers: headers, params: params)
    }
    
    public func post(_ url: String,
                     headers: [String: String]? = nil,
                     params: [String: Any]? = nil) -> Request
    {
        return Request(method: "POST", url: url, headers: headers, params: params)
    }
    
    public func patch(_ url: String,
                      headers: [String: String]? = nil,
                      params: [String: Any]? = nil) -> Request
    {
        return Request(method: "PATCH", url: url, headers: headers, params: params)
    }
    
    public func put(_ url: String,
                    headers: [String: String]? = nil,
                    params: [String: Any]? = nil) -> Request
    {
        return Request(method: "PUT", url: url, headers: headers, params: params)
    }
    
    public func delete(_ url: String,
                       headers: [String: String]? = nil,
                       params: [String: Any]? = nil) -> Request
    {
        return Request(method: "DELETE", url: url, headers: headers, params: params)
    }
}
