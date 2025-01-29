//
//  FeedView.swift
//  XClone
//
//  Created by Zaman Kazimov on 19.01.25.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel: FeedViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(authStateManager: AuthStateManager = .shared) {
        _viewModel = StateObject(wrappedValue: FeedViewModel(authStateManager: authStateManager))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 33, height: 33)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Image(colorScheme == .light ? "logoWhiteMode" : "logoDarkMode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Menu {
                    Button("Timeline Settings") {
                        print("Timelinse settings clicked...")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .font(.title)
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    FeedView(authStateManager: AuthStateManager.shared)
}
