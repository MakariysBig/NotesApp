import Foundation

protocol RepositoryProtocol {
    func getNews(completion: @escaping (Result< NewsModel, Error >) -> Void)
}

final class Repository: RepositoryProtocol {
    private let networkEngine: NetworkEngine

    init(networkEngine: NetworkEngine = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    func getNews(completion: @escaping (Result< NewsModel, Error >) -> Void) {
        networkEngine.request(endpoint: NewsEndpoint.getData, completion: completion)
    }
}
