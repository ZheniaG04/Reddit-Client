//
//  NetworkManager.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import Foundation

class NetworkManager {
    private let redditURL = "https://www.reddit.com/top.json"
    private let postsLimit = 10
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetchData(after: String? = nil, completion: @escaping (Result<[Post], Error>) -> Void) {
        var urlComponents = URLComponents(string: redditURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "\(postsLimit)")
        ]
        if let afterParam = after {
            urlComponents?.queryItems?.append(URLQueryItem(name: "after", value: afterParam))
        }
        guard let url = urlComponents?.url else {
            preconditionFailure("Failed to construct search URL")
        }
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                if let safeData = data {
                    do {
                        let results = try self.decoder.decode(PostList.self, from: safeData)
                        completion(.success(results.posts))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
