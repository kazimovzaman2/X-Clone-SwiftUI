//
//  FeedViewModel.swift
//  XClone
//
//  Created by Zaman Kazimov on 22.01.25.
//

import Foundation
import SwiftUI

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var errorMessage: String?
    
    @ObservedObject var authStateManager: AuthStateManager
    private let authService: AuthService
    private let postService: PostService
    
    init(authService: AuthService = .shared, authStateManager: AuthStateManager = .shared, postService: PostService = .shared) {
        self.authService = authService
        self.authStateManager = .shared
        self.postService = postService
    }
    
    func fetchPosts() async {
        errorMessage = nil
        
        do {
            posts = try await postService.fetchPosts()
        } catch {
            errorMessage = "Failed to load posts."
        }
    }
    
    func logout() async {
        errorMessage = nil
        
        do {
            guard let accessToken = KeychainManager.load(key: "accessToken") else {
                errorMessage = "Access token is missing."
                return
            }
            _ = try await authService.logout(accessToken: accessToken)
            
            authStateManager.logout()
        } catch let error as AuthError {
            switch error {
            case .badURL:
                errorMessage = "Invalid URL. Please try again."
            case .badServerResponse:
                errorMessage = "Server responded with an error. Please try again later."
            case .serverError(let message):
                errorMessage = "Server error: \(message)"
            case .cannotParseResponse:
                errorMessage = "Failed to process the response. Please try again."
            case .networkError(let message):
                errorMessage = "Network error: \(message)"
            case .unauthorized:
                errorMessage = "Unauthorized. Please log in again."
            }
        } catch {
            errorMessage = "Login failed due to an unknown error. Please try again."
        }
    }
}
