//
//  AuthService.swift
//  XClone
//
//  Created by Zaman Kazimov on 20.01.25.
//


import Foundation



enum AuthError: LocalizedError {
    case badURL
    case badServerResponse
    case serverError(String)
    case cannotParseResponse
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL is invalid."
        case .badServerResponse:
            return "Server responded with an error."
        case .serverError(let message):
            return message
        case .cannotParseResponse:
            return "Failed to parse server response."
        case .networkError(let message):
            return message
        }
    }
}


class AuthService {
    static let shared = AuthService()
    private init() {}

    private let baseURL = "http://127.0.0.1:8000/api"
    private let loginEndpoint = "/jwt/create/"

    func login(email: String, password: String) async throws -> (accessToken: String, refreshToken: String) {
        guard let url = URL(string: baseURL + loginEndpoint) else {
            throw URLError(.badURL)
        }

        let requestBody = [
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                if !data.isEmpty,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let errors = json["errors"] as? [[String: Any]],
                   let firstError = errors.first,
                   let errorDetail = firstError["detail"] as? String {
                    throw AuthError.serverError(errorDetail)
                } else {
                    throw AuthError.badServerResponse
                }
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let accessToken = json["access"] as? String, let refreshToken = json["refresh"] as? String {
                return (accessToken, refreshToken)
            } else {
                throw AuthError.cannotParseResponse
            }
        } catch let error as AuthError {
            throw error
        } catch {
            throw AuthError.networkError("Some error happen here")
        }
    }
}
