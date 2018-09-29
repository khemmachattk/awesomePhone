import Foundation
import Alamofire

enum RouterConfiguration {
    static let baseURLPath = "https://scb-test-mobile.herokuapp.com/api"
}

protocol Routable: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: Dictionary<String, String>? { get }
    var version: Int { get }
}

extension Routable {
    public func asURLRequest() throws -> URLRequest {
        let url = try RouterConfiguration.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
