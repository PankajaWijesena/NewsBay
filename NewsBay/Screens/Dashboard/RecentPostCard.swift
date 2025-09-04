//
//  RecentPostCard.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//


import SwiftUI

struct RecentPostCard: View {
    let authorName: String
    let title: String
    let content: String
    let likesCount: Int
    let commentsCount: Int
    let timeAgo: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                AvatarPlaceholder(
                    text: authorName.getInitials(),
                    foregroundColor: Color.primary1,
                    backgroundColor: Color.customWhite,
                )
                .font(.customFont(.lexend400, size: 14))
                .frame(width: 32, height: 32)
                Text(authorName)
                    .font(.customFont(.lexend500, size: 14))
                    .foregroundStyle(Color.onSurface)
            }
            Text(title)
                .font(.customFont(.lexend600, size: 16))
                .foregroundStyle(Color.onSurface)
            Text(content)
                .lineLimit(2, reservesSpace: true)
                .font(.customFont(.lexend400, size: 14))
                .foregroundStyle(Color.secondary)
            HStack(alignment: .center, spacing: 20) {
                PostMetadataArea(
                    emoji: "❤️",
                    text: "\(likesCount)",
                )
                PostMetadataArea(
                    emoji: "💬",
                    text: "\(commentsCount)",
                )
                PostMetadataArea(
                    emoji: "🕒",
                    text: timeAgo,
                )
            }
        }
        .padding(.all, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.customWhite)
        .clipShape(.rect(cornerRadius: 16))
        .cardShadow()
    }
}

extension RecentPostCard {
    @ViewBuilder static func placeholder() -> some View {
        RecentPostCard(
            authorName: "Placeholder",
            title: "Placeholder Post Title",
            content: "loripsum loremipsum loremipsum loremipsum loremipsum loremipsum loremipsum loremipsum loremipsum ipsum",
            likesCount: 0,
            commentsCount: 0,
            timeAgo: "x minutes ago",
        )
        .redacted(reason: .placeholder)
    }
}
