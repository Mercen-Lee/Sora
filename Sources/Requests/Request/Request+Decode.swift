import Foundation

extension Request {
    public func decode<T: Codable>(_ type: T.Type,
                            completion: @escaping (T) -> Void)
    {
        let request = self.build()
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                if let decodedData = try? decoder.decode(T.self, from: data) {
                    completion(decodedData)
                }
            }
        }).resume()
    }
}
