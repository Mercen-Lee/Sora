//
//  Requestable.swift
//
//  Copyright (c) 2024 Mercen
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import Alamofire

/// A type used to define a request can be converted to the `URLRequest`.
public protocol Requestable: URLRequestConvertible {
    
    /// The `Service` route of the request.
    associatedtype ServiceType: Service
    var route: ServiceType { get }
    
    /// The HTTP method of the request.
    var method: RequestMethod { get }
    
    /// The `encoder` of the parameter.
    var encoder: ParameterEncoder { get }
    
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
    
    /// Executes a `request` asynchronously or throws if an `Error` was encountered.
    ///
    /// - Throws:  Any error thrown while executing the `request`.
    func request() async throws
    
    /// Returns a `Decodable` asynchronously or throws if an `Error` was encountered.
    ///
    /// - Parameters:
    ///   - decodeWith: `Decodable` value to decode the response data.
    ///   - decoder:    `JSONDecoder` to decode the data with `decodeWith`.
    ///
    /// - Returns:      Decoded `Decodable` struct.
    /// - Throws:       Any error thrown while executing the `request`.
    func request<T: Decodable>(decodeWith: T.Type,
                               decoder: JSONDecoder?) async throws -> T
}

public extension Requestable {
    
    /// A default `encoder` of the parameter.
    var encoder: ParameterEncoder {
        method.encoder
    }
    
    /// An implement of `asURLRequest` method of `Requestable`.
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: route.url)
        request.httpMethod = method.rawValue
        guard let body = self as? any Body else { return request }
        return try encoder.encode(body.body, into: request)
    }
    
    /// An implement of `request` method of `Requestable`.
    func request() async throws {
        let _ = try await self.request(decodeWith: Empty.self)
    }
    
    /// An implement of `request` method of `Requestable` with `Decodable`.
    func request<T: Decodable>(decodeWith: T.Type,
                               decoder: JSONDecoder? = nil) async throws -> T {
        let response = await AF.request(self)
            .validate()
            .serializingDecodable(T.self, decoder: decoder ?? route.decoder)
            .response
        switch response.result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
