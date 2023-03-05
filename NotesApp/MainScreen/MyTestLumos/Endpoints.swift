import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

//MARK: - News Endpoint

enum NewsEndpoint: Endpoint {
    case getData
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURl: String {
        switch self {
        default:
            return "gfeheb.space"
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "/api/v2/news"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getData:
            return [
                     URLQueryItem(name: "token", value: "55b9a408-9277-11ed-a1eb-0242ac120002")
            ]
        }
    }

    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
