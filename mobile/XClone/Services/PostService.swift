//
//  PostService.swift
//  XClone
//
//  Created by Zaman Kazimov on 01.02.25.
//

import Foundation

struct APIResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PostModel]
}


class PostService {
    static let shared = PostService()
    
    private init() {}
    
    private let baseURL = "http://127.0.0.1:8000/api/posts/"
    
    func fetchPosts() async throws -> [PostModel] {
        guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        guard let accessToken = KeychainManager.load(key: "accessToken") else {
            throw AuthError.badServerResponse
        }
        
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                return decodedResponse.results
            case 403:
                return try await fetchPosts()
            default:
                throw AuthError.badServerResponse
            }
        }
        throw AuthError.badServerResponse
    }
}
