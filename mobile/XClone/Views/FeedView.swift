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
    
    private var posts: [PostModel] = [
        PostModel(
            username: "kazimovzaman2",
            firstName: "Zaman",
            content: "Breaking! New White House Press Secretary Vows To Call Out Lying MSM Outlets For Producing Fake News Against Trump, His Family And His Agenda.",
            timestamp: Date(),
            image: URL(string: "https://w0.peakpx.com/wallpaper/961/425/HD-wallpaper-2023-porsche-911-gt3-rs-coupe-flat-6-car.jpg"),
            commentCount: 10,
            repostCount: 5,
            likeCount: 12300,
            chartCount: 700
        ),
        PostModel(
            username: "john_doe",
            firstName: "John",
            content: "Check out my latest adventure in the mountains!",
            timestamp: Date().addingTimeInterval(-3600),
            image: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg/800px-Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg"),
            commentCount: 50,
            repostCount: 20,
            likeCount: 20000,
            chartCount: 1000
        )
    ]
    
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
            
            List(posts) { post in
                PostView(post: post)
                    .listRowInsets(EdgeInsets())
            }
            .padding(.top, 0)
            .listStyle(PlainListStyle())
            .background(Color.clear)
            
        }
    }
}

#Preview {
    FeedView(authStateManager: AuthStateManager.shared)
}
