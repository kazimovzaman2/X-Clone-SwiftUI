//
//  AuthStateManager.swift
//  XClone
//
//  Created by Zaman Kazimov on 20.01.25.
//

import Foundation

class AuthStateManager: ObservableObject {
    @Published var isAuthenticated: Bool {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }
    
    static let shared = AuthStateManager()
    
    private init() {
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        Task {
            await checkAuthState()
        }
    }
    
    func login(tokens: AuthTokens) {
        isAuthenticated = true
        
        KeychainManager.save(key: "accessToken", value: tokens.accessToken)
        KeychainManager.save(key: "refreshToken", value: tokens.refreshToken)
    }
    
    func logout() {
        self.isAuthenticated = false
        
        KeychainManager.delete(key: "accessToken")
        KeychainManager.delete(key: "refreshToken")
    }
    
    func checkAuthState() async {
        guard let accessToken = KeychainManager.load(key: "accessToken"), let refreshToken = KeychainManager.load(key: "refreshToken") else {
            logout()
            return
        }
        
        let isValid = await isAccessTokenValid(accessToken)
        
        if isValid {
            self.isAuthenticated = true
        } else {
            await refreshAccessToken(refreshToken: refreshToken)
        }
    }
    
    private func isAccessTokenValid(_ accessToken: String) async -> Bool {
        do {
            return try await AuthService.shared.verifyToken(accessToken: accessToken)
        } catch {
            return false
        }
    }
    
    private func refreshAccessToken(refreshToken: String) async {
        do {
            let newTokens = try await AuthService.shared.refreshAccessToken(refreshToken: refreshToken)
            self.login(tokens: newTokens)
        } catch {
            self.logout()
        }
    }
}
