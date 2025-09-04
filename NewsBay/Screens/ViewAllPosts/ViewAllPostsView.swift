//
//  ViewAllPostsView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct ViewAllPostsView: View {
    let posts: [Post]
    let isLoadingComplete: Bool
    let fetchPostsAction: () -> Void
    let refreshPostsAction: () -> Void

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 16) {
                RecentPostsSection(
                    posts: posts,
                    isLoadingComplete: isLoadingComplete,
                    fetchPostsAction: fetchPostsAction
                )
            }
            .padding(.all, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .scrollIndicators(.hidden)
        .refreshable {
            refreshPostsAction()
        }
        .navigationTitle("View All Posts")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
        }
    }
}

#Preview("View All Posts") {
    ViewAllPostsView(
        posts: [],
        isLoadingComplete: false,
        fetchPostsAction: {},
        refreshPostsAction: {}
    )
    .preferredColorScheme(.light)
}
