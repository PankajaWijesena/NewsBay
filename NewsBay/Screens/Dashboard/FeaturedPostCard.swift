//
//  FeaturedPostCard.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct FeaturedPostCard: View {
    let title: String
    let author: String
    let likesCount: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                Color.primary1
                Text("📖")
                    .font(.customFont(.lexend400, size: 24))
            }
            .frame(height: 160)
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .lineLimit(2, reservesSpace: true)
                    .font(.customFont(.lexend500, size: 16))
                    .foregroundStyle(Color.onSurface)
                HStack(alignment: .center, spacing: 12) {
                    PostMetadataArea(
                        emoji: "👤",
                        text: author,
                    )
                    PostMetadataArea(
                        emoji: "❤️",
                        text: "\(likesCount)",
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.all, 16)
        }
        .frame(width: 280)
        .background(Color.customWhite)
        .clipShape(.rect(cornerRadius: 20))
        .cardShadow()
    }
}

extension FeaturedPostCard {
    @ViewBuilder static func placeholder() -> some View {
        FeaturedPostCard(
            title: "Placeholder Post Title",
            author: "Placeholder",
            likesCount: 0,
        )
        .redacted(reason: .placeholder)
    }
}
