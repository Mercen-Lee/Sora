//
//  Service.swift
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

/// A type used to define a service for the `Requestable`.
public protocol Service {
    
    /// The endpoint of the service.
    var endpoint: URL { get }
    
    /// The URL path can be appended to the `endpoint`.
    var path: [String] { get }
    
    /// The URL composed with the `endpoint` and the `path`
    var url: URL { get }
    
    /// The `RequestInterceptor` of `Alamofire`.
    var interceptor: RequestInterceptor { get }
    
    /// The default `JSONDecoder` of the service.
    var decoder: JSONDecoder { get }
    
    /// An initializer with the `path`
    init(path: [String])
    
    /// Creates a `Service` from a `path`.
    ///
    /// - Parameters:
    ///   - path:  `String...` value to be used to create the `Service`.
    ///
    /// - Returns: The created `Service`.
    static func path(_ of: String...) -> Self
}

public extension Service {
    
    /// The URL composed with the `endpoint` and the `path`
    var url: URL {
        path.reduce(endpoint) {
            $0.appendingPathComponent($1)
        }
    }
    
    /// The `RequestInterceptor` of `Alamofire`.
    var interceptor: RequestInterceptor { Interceptor() }
    
    /// The default `JSONDecoder` of the service.
    var decoder: JSONDecoder { .init() }
    
    /// A simple implement of `path` method of `Service`.
    static func path(_ of: String...) -> Self {
        .init(path: of)
    }
}
