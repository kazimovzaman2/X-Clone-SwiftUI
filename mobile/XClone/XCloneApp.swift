//
//  XClone.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

@main
struct XCloneApp: App {
    @State private var isAuthenticated: Bool = false

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                FeedView(isAuthenticated: $isAuthenticated)
            } else {
                IntroView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}
