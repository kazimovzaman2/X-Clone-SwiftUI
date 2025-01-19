//
//  CreateAccountData.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//


import SwiftUI

class CreateAccountData: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
}
