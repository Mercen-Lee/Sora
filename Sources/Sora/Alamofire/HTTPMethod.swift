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

import Alamofire

/// Type representing HTTP methods. Raw `String` value is stored and compared case-sensitively, so
/// `HTTPMethod.get != HTTPMethod(rawValue: "get")`.
public enum HTTPMethod: String {
    
    /// `CONNECT` method.
    case connect = "CONNECT"
    
    /// `DELETE` method.
    case delete = "DELETE"
    
    /// `GET` method.
    case get = "GET"
    
    /// `HEAD` method.
    case head = "HEAD"
    
    /// `OPTIONS` method.
    case options = "OPTIONS"
    
    /// `PATCH` method.
    case patch = "PATCH"
    
    /// `POST` method.
    case post = "POST"
    
    /// `PUT` method.
    case put = "PUT"
    
    /// `QUERY` method.
    case query = "QUERY"
    
    /// `TRACE` method.
    case trace = "TRACE"
    
    /// Defining default `encoding` of the `HTTPMethod`.
    var encoding: any ParameterEncoding {
        switch self {
        case .post, .put, .patch, .delete:
            JSONEncoding.default
        default:
            URLEncoding.default
        }
    }
}
