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
    case unauthorized
    
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
        case .unauthorized:
            return "Unauthorized. Please log in again."
        }
    }
}


class AuthService {
    static let shared = AuthService()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:8000/api"
    private let loginEndpoint = "/jwt/create/"
    private let logoutEndpoint = "/jwt/logout/"
    private let registerEndpoint = "/register/"
    private let refreshEndpoint = "/jwt/refresh/"
    private let verifyEndpoint = "/jwt/verify/"
    
    func login(email: String, password: String) async throws -> AuthTokens {
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
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AuthError.badServerResponse
        }
        
        return try JSONDecoder().decode(AuthTokens.self, from: data)
    }
    
    func logout(accessToken: String) async throws -> String {
        guard let url = URL(string: baseURL + logoutEndpoint) else {
            throw AuthError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
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
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let message = json["message"] as? String {
                return message
            } else {
                throw AuthError.cannotParseResponse
            }
        } catch let error as AuthError {
            throw error
        } catch {
            throw AuthError.networkError("An unexpected error occurred.")
        }
    }
    
    func register(firstName: String, lastName: String, email: String, password: String) async throws -> AuthTokens {
        guard let url = URL(string: baseURL + registerEndpoint) else {
            throw URLError(.badURL)
        }
        
        let requestBody = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw AuthError.unauthorized
        }
        
        return try JSONDecoder().decode(AuthTokens.self, from: data)
    }
    
    func refreshAccessToken(refreshToken: String) async throws -> AuthTokens {
        guard let url = URL(string: baseURL + refreshEndpoint) else {
            throw URLError(.badURL)
        }
        
        let requestBody = ["refresh": refreshToken]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AuthError.unauthorized
        }
        
        let tokens = try JSONDecoder().decode(AuthTokens.self, from: data)
        return tokens
    }
    
    func verifyToken(accessToken: String) async throws -> Bool {
        guard let url = URL(string: baseURL + verifyEndpoint) else {
            throw URLError(.badURL)
        }
        
        let requestBody = ["token": accessToken]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                return true
            case 401, 403:
                return false
            default:
                throw URLError(.badServerResponse)
            }
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
