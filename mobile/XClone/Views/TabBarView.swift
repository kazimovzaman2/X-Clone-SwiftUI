//
//  TabBarView.swift
//  XClone
//
//  Created by Zaman Kazimov on 29.01.25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            Text("Grok")
                .tabItem {
                    Label("Grok", systemImage: "figure.sailing")
                }
            
            Text("Notifications")
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
        }
    }
}

#Preview {
    TabBarView()
}
