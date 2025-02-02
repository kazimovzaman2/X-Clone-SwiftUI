//
//  PostView.swift
//  XClone
//
//  Created by Zaman Kazimov on 29.01.25.
//

import SwiftUI
import AVKit


struct PostView: View {
    let post: PostModel
    
    private var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        if let date = ISO8601DateFormatter().date(from: post.postedAt) {
            return formatter.string(from: date)
        }
        return "Unknown Date"
    }
    
    private func formatCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return String(format: "%.0fM", Double(count) / 1_000_000)
        } else if count >= 1_000 {
            return String(format: "%.0fK", Double(count) / 1_000)
        } else {
            return "\(count)"
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width * 0.1)
            
            VStack {
                HStack {
                    Text(post.user.firstName)
                        .font(.headline)
                    
                    Text("@\(post.user.email) · \(formattedTimestamp)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text(post.content)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let imageURL = URL(string: post.file) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        case .success(let image):
                            image.resizable().scaledToFit().frame(maxWidth: .infinity).cornerRadius(10)
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                                .overlay(
                                    Text("Failed to load image")
                                        .foregroundColor(.gray)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                )
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                HStack(spacing: 15) {
                    actionButton(label: "Comment", systemImage: "bubble.left", count: 5)
                    actionButton(label: "Repost", systemImage: "arrow.triangle.2.circlepath", count: 4)
                    actionButton(label: "Like", systemImage: "heart", count: 4)
                    actionButton(label: "Chart", systemImage: "chart.bar.xaxis", count: 4)
                    
                    HStack (spacing: 10) {
                        actionButtonWithoutCount(label: "Save", systemImage: "bookmark")
                        actionButtonWithoutCount(label: "Share", systemImage: "square.and.arrow.up")
                    }
                }
                .font(.body)
                .foregroundColor(.blue)
                .padding(.top, 10)
            }
        }
        .padding()
    }
    
    private func actionButton(label: String, systemImage: String, count: Int) -> some View {
        HStack(spacing: 1) {
            let formattedCount = formatCount(count)

            Button(action: {
                print("\(label) clicked")
            }) {
                Label(label, systemImage: systemImage)
                    .labelStyle(IconOnlyLabelStyle())
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(red: 113 / 255, green: 118 / 255, blue: 123 / 255))
            }
            Text("\(formattedCount)")
                .font(.footnote)
                .foregroundStyle(Color(red: 113 / 255, green: 118 / 255, blue: 123 / 255))
        }
    }
    
    private func actionButtonWithoutCount(label: String, systemImage: String) -> some View {
            Button(action: {
                print("\(label) clicked")
            }) {
                Label(label, systemImage: systemImage)
                    .labelStyle(IconOnlyLabelStyle())
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(red: 113 / 255, green: 118 / 255, blue: 123 / 255))
            }
        }
}

#Preview {
    PostView(post: PostModel(id: 3, file: "https://images-porsche.imgix.net/-/media/1DBDC37E82084CF496EE48FCCE48BE0A_4D115F6379CF4C299F1F38641CE865F0_911-gt3-side?w=600&q=85&crop=faces%2Centropy%2Cedges&auto=format", content: "test", postedAt: "2025-01-31T20:50:10.215193+04:00", user: UserModel(id: 1, firstName: "Zaman", lastName: "Kazimov", email: "kazimovzaman2@gmail.com", profilePicture: "https://images-porsche.imgix.net/-/media/1DBDC37E82084CF496EE48FCCE48BE0A_4D115F6379CF4C299F1F38641CE865F0_911-gt3-side?w=600&q=85&crop=faces%2Centropy%2Cedges&auto=format")))
}
