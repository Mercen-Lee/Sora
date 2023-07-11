import Foundation

public class Request {
    
    let method: String
    let url: URL
    let headers: [String: String]?
    let params: [String: Any]?
    
    init(method: String,
         url: String,
         headers: [String: String]?,
         params: [String: Any]?) {
        self.method = method
        self.url = URL(string: url) ?? URL(string: "about:blank")!
        self.headers = headers
        self.params = params
    }
}

extension Request {
    func build() -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.method
        if let headers = self.headers {
            Array(headers.keys).forEach { key in
                request.setValue(headers[key], forHTTPHeaderField: key)
            }
        }
        if let params = self.params {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        return request
    }
}
