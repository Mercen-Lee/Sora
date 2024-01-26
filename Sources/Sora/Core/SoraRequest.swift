//
//  SoraRequest.swift
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
public protocol SoraRequest: URLRequestConvertible {
    
    /// The `Body`(a.k.a. parameter) for the request.
    associatedtype Body: Encodable
    
    /// The `SoraService` of the request.
    associatedtype Service: SoraService
    var service: Service { get }
    
    /// The HTTP method of the request.
    var method: HTTPMethod { get }
    
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}

public extension SoraRequest {
    
    /// A simple implement of `asURLRequest` method of `Alamofire`.
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: service.url)
        request.httpMethod = method.rawValue
        return request
    }
}
