//
//  PostModel.swift
//  XClone
//
//  Created by Zaman Kazimov on 01.02.25.
//

import Foundation

struct PostModel: Codable {
    let id: Int
    let file: String
    let content: String
    let postedAt: String
    let user: UserModel
}
