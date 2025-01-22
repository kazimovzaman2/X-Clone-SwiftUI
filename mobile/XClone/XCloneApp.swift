//
//  XClone.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

@main
struct XCloneApp: App {
    @StateObject private var authStateManager = AuthStateManager.shared
    
    var body: some Scene {
        WindowGroup {
            if authStateManager.isAuthenticated {
                FeedView(authStateManager: authStateManager)
            } else {
                IntroView(authStateManager: authStateManager)
            }
        }
    }
}
