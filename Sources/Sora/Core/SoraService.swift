//
//  SoraService.swift
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

/// A type used to define a service for the `SoraRequest`.
public protocol SoraService {
    
    /// The endpoint of the service.
    var endpoint: URL { get }
    
    /// The URL path can be appended to the `endpoint`.
    var path: [String] { get set }
    
    /// The URL composed with the `endpoint` and the `path`
    var url: URL { get }
    
    /// The `Interceptor` of `Alamofire`.
    var interceptor: Interceptor { get }
    
    /// Default Initializer
    init()
    
    /// An initializer with the `Path`
    init(path: String...)
}

public extension SoraService {
    
    /// The URL path can be appended to the `endpoint`.
    var path: [String] {
        get { .init() }
        set { }
    }
    
    /// The URL composed with the `endpoint` and the `path`
    var url: URL {
        path.reduce(endpoint) {
            $0.appendingPathComponent($1)
        }
    }
    
    /// The `Interceptor` of Alamofire.
    var interceptor: Interceptor { .init() }
    
    /// Default Initializer
    init() { self.init() }
    
    /// An initializer with the `Path`
    init(path: String...) {
        self.init()
        self.path = path
    }
}
