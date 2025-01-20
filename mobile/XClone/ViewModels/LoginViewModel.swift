//
//  LoginViewModel.swift
//  XClone
//
//  Created by Zaman Kazimov on 20.01.25.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var user = LoginData()
    @Published var isEmailValid = true
    @Published var isFormValid = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService: AuthService
    private let authStateManager: AuthStateManager

    init(authService: AuthService = .shared, authStateManager: AuthStateManager = .shared) {
        self.authService = authService
        self.authStateManager = .shared
    }

    func validateEmail() {
        isEmailValid = user.email.isValidEmail
    }

    func validateForm() {
        isFormValid = !user.email.isEmpty && !user.password.isEmpty
    }

    func login() async {
        isLoading = true
        defer { isLoading = false }
        errorMessage = nil

        do {
            let tokens = try await authService.login(email: user.email, password: user.password)
            KeychainManager.save(key: "accessToken", value: tokens.accessToken)
            KeychainManager.save(key: "refreshToken", value: tokens.refreshToken)

            authStateManager.login()
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
            }
        } catch {
            errorMessage = "Login failed due to an unknown error. Please try again."
        }
    }
}
