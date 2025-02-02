//
//  UserModel.swift
//  XClone
//
//  Created by Zaman Kazimov on 01.02.25.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let profilePicture: String?
}
