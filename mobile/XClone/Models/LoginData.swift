//
//  LoginData.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//


import SwiftUI

class LoginData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
