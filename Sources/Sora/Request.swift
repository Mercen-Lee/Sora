public protocol Request {
    var endpoint: String { get }
    var method: HTTPMethod { get }
}
