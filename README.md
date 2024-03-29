![Sora](https://raw.githubusercontent.com/Mercen-Lee/Sora/main/Resources/SoraLogo.svg)

![Swift](https://img.shields.io/badge/Swift-5.5_5.6_5.7_5.8-Orange?style=flat-square)
![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS_tvOS_watchOS-yellowgreen?style=flat-square)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)

> Elegant Networking in Swift. But more Swift.

Sora is an **declarative Alamofire wrapper**.

## Requirements
| Platform | Minimum Swift Version | Installation |
| --- | --- | --- |
| iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+ | 5.5 | [Swift Package Manager](#swift-package-manager) |

## Installation
### Swift Package Manager
- `File` -> `Add Packages...` And paste the repository URL.
- Or add it to the `dependencies` value of your `Package.swift`.
```swift
dependencies: [
  .package(url: "https://github.com/Mercen-Lee/Sora.git", .branch("main"))
]
```

## Usage
### Service
```swift
struct Sample: Service {

    let endpoint: URL = .init(string: "https://sample.com/api/")!
    let interceptor: Interceptor = .init()
    let path: [String]
}
```
### GET Request
```swift
struct GetUserRequest: Requestable {

    let route = Sample.path("user")
    let method: RequestMethod = .get
}

AF.request(GetUserRequest())
```
### POST Request
```swift
struct PostUserRequest: Requestable, Body {

    let route = Sample.path("user", "post")
    let method: RequestMethod = .post
    
    let body: Body
    
    struct Body: Encodable {
        let id: Int
        let name: String
    }
}

AF.request(PostUserRequest(body: .init(id: 1, name: "mercen")))
```
### Simple Concurrency
```swift
do {
    let response = try await GetUserRequest()
        .request(with: AnyDecodable.self)
} catch let error {
    // on Error
}
```
