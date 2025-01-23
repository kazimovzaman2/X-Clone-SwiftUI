//
//  UserService.swift
//  XClone
//
//  Created by Zaman Kazimov on 23.01.25.
//


import Foundation



class UserService {
    static let shared = UserService()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:8000/api"
    private let verifyURL = "/users/"
}
