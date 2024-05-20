//
//  APICaller.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 02.10.2023.
//

import Foundation

enum APIError: Error {
    case failedToGetData
    case text(String)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    enum Endpoint {
        case users
        case posts
        case comments
        var url: URL {
            switch self {
            case .users:
               return URL(string: "\(baseUrl)/users")!
            case .posts:
                return URL(string: "\(baseUrl)/posts")!
            case .comments:
                return URL(string: "\(baseUrl)/comments")!
            }
        }
    }
    
    func getUser(completion: @escaping (Result<[UserRealm], Error>) -> Void) {
        request(URLRequest(url: Endpoint.users.url), decodeType: [UserRealm].self, completion: completion)
    }
    
    func getPost(completion: @escaping (Result<[PostRealm], Error>) -> Void) {
        request(URLRequest(url: Endpoint.posts.url), decodeType: [PostRealm].self, completion: completion)
    }
    
    func getComment(_ postID: Int ,completion: @escaping (Result<[CommentRealm], Error>) -> Void) {
        request(URLRequest(url: Endpoint.comments.url), decodeType: [CommentRealm].self, completion: completion)
    }
    
    
    func request<T: Decodable>(
        _ request: URLRequest,
        decodeType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.text("error")))
                }
                return
            }
            let result = Result {
               try JSONDecoder().decode(T.self, from: data)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
