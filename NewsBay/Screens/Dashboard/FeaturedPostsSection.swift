//
//  FeaturedPostsSection.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct FeaturedPostsSection: View {
    let posts: [Post]
    let isLoadingComplete: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 12) {
                if isLoadingComplete {
                    ForEach(posts, id: \.id) { post in
                        FeaturedPostCard(
                            title: post.title,
                            author: "Author X",
                            likesCount: post.reactions.likes,
                        )
                    }
                } else {
                    FeaturedPostCard.placeholder()
                }
            }
            .padding(.all, 16)
        }
    }
}
