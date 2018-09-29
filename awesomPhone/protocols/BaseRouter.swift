import Foundation
import Alamofire

enum RouterConfiguration {
    static let baseURLPath = "https://scb-test-mobile.herokuapp.com/api"
}

protocol Routable: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension Routable {
    public func asURLRequest() throws -> URLRequest {
        let url = try RouterConfiguration.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
