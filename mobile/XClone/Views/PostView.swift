//
//  PostView.swift
//  XClone
//
//  Created by Zaman Kazimov on 29.01.25.
//

import SwiftUI
import AVKit

struct PostModel: Identifiable {
    let id = UUID()
    let username: String
    let firstName: String
    let content: String
    let timestamp: Date
    let image: URL?
    let commentCount: Int
    let repostCount: Int
    let likeCount: Int
    let chartCount: Int
}


struct PostView: View {
    let post: PostModel
    
    private var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        return formatter.string(from: post.timestamp)
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
                    Text(post.firstName)
                        .font(.headline)
                    
                    Text("@\(post.username) · \(formattedTimestamp)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text(post.content)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let imageURL = post.image {
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
                    actionButton(label: "Comment", systemImage: "bubble.left", count: post.commentCount)
                    actionButton(label: "Repost", systemImage: "arrow.triangle.2.circlepath", count: post.repostCount)
                    actionButton(label: "Like", systemImage: "heart", count: post.likeCount)
                    actionButton(label: "Chart", systemImage: "chart.bar.xaxis", count: post.chartCount)
                    
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
    PostView(post: PostModel(
        username: "kazimovzaman2",
        firstName: "Zaman",
        content: "Breaking! New White House Press Secretary Vows To Call Out Lying MSM Outlets For Producing Fake News Against Trump, His Family And His Agenda.",
        timestamp: Date(),
        image: URL(string: "https://w0.peakpx.com/wallpaper/961/425/HD-wallpaper-2023-porsche-911-gt3-rs-coupe-flat-6-car.jpg"),
        commentCount: 10,
        repostCount: 5,
        likeCount: 12300,
        chartCount: 700
    ))
}
