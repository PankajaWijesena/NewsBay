//
//  RecentPostsSection.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct RecentPostsSection: View {
    let posts: [Post]
    let isLoadingComplete: Bool
    let fetchPostsAction: () -> Void
    
    var body: some View {
        Group {
            if isLoadingComplete {
                ForEach(posts, id: \.id) { post in
                    RecentPostCard(
                        authorName: "Author X",
                        title: post.title,
                        content: post.body,
                        likesCount: post.reactions.likes,
                        commentsCount: 0,
                        timeAgo: "x minutes ago",
                    )
                    .task {
                        if post.id == posts.last?.id {
                            fetchPostsAction()
                        }
                    }
                }
            } else {
                RecentPostCard.placeholder()
            }
        }
    }
}
