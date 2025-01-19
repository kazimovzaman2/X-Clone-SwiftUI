//
//  FeedView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct FeedView: View {
    @Binding var isAuthenticated: Bool
    @State private var tweets: [String] = [
        "Hello, XClone!",
        "Building a SwiftUI app is fun! 🚀",
        "What's your favorite programming language?",
        "Stay curious and keep learning. 🌟",
        "Follow me for more updates!"
    ]

    var body: some View {
        NavigationStack {
            List(tweets, id: \.self) { tweet in
                Text(tweet)
                    .padding(.vertical, 8)
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        isAuthenticated = false
                    }
                }
            }
        }
    }
}

#Preview {
    FeedView(isAuthenticated: .constant(true))
}
