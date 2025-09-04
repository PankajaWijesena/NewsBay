//
//  DashboardView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel(
        respository: RemotePostRepository()
    )
    @State private var isNavigatingToViewAllPosts: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                
                // MARK: - TOP BAR
                VStack(alignment: .center, spacing: 12) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("Good Morning!")
                            .font(.customFont(.lexend700, size: 22))
                            .foregroundStyle(Color.onSurface)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        AvatarPlaceholder(
                            text: "EH",
                            foregroundColor: Color.customBlue,
                            backgroundColor: Color.customWhite,
                        )
                        .font(.customFont(.lexend400, size: 14))
                        .frame(width: 40, height: 40)
                    }
                    SearchField(
                        query: $viewModel.searchQuery,
                        placeholder: "Search posts ..."
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                ScrollView(.vertical) {
                    LazyVStack(alignment: .center, spacing: 0) {
                        
                        // MARK: - FEATURED POSTS
                        LazyVStack(alignment: .center, spacing: 0) {
                            PostsSectionHeader(
                                title: "Featured Posts",
                                viewAllAction: {
                                    isNavigatingToViewAllPosts.toggle()
                                },
                            )
                            .padding(.horizontal, 16)
                            FeaturedPostsSection(
                                posts: viewModel.posts,
                                isLoadingComplete: viewModel
                                    .isInitialLoadingComplete
                            )
                        }
                        
                        // MARK: - RECENT POSTS
                        LazyVStack(alignment: .center, spacing: 16) {
                            PostsSectionHeader(
                                title: "Recent Posts",
                                viewAllAction: {
                                    isNavigatingToViewAllPosts.toggle()
                                },
                            )
                            RecentPostsSection(
                                posts: viewModel.posts,
                                isLoadingComplete: viewModel
                                    .isInitialLoadingComplete,
                                fetchPostsAction: viewModel.fetchPosts
                            )
                        }
                        .padding(.all, 16)
                    }
                    .padding(.top, 16)
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.refreshPosts()
                }
            }
            .background(Color.customWhite)
            .navigationDestination(isPresented: $isNavigatingToViewAllPosts) {
                ViewAllPostsView(
                    posts: viewModel.posts,
                    isLoadingComplete: viewModel.isInitialLoadingComplete,
                    fetchPostsAction: viewModel.fetchPosts,
                    refreshPostsAction: viewModel.refreshPosts
                )
            }
            .task {
                if !viewModel.isInitialLoadingComplete {
                    viewModel.fetchPosts()
                }
            }
        }
    }
}

#Preview("Dashboard") {
    DashboardView()
        .preferredColorScheme(.light)
}
