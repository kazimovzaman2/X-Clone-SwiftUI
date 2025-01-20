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
    }

    func login() {
        isAuthenticated = true
    }

    func logout() {
        self.isAuthenticated = false

        KeychainManager.delete(key: "accessToken")
        KeychainManager.delete(key: "refreshToken")
    }

    func checkAuthState() -> Bool {
        if KeychainManager.load(key: "accessToken") != nil,
           KeychainManager.load(key: "refreshToken") != nil {
            isAuthenticated = true
        }
        
        isAuthenticated = false
        return false
    }
}
