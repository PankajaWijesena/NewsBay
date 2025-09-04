//
//  MainTabView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension MainTabView {
    enum TabItem: String, CaseIterable {
        case dashboard = "Home"
        case topRate = "Top Rate"
        case news = "News"
        case chat = "Chat"
        case profile = "Profile"
        
        @ViewBuilder func view(isLoggedIn: Binding<Bool>) -> some View {
            switch self {
            case .dashboard: DashboardView()
            case .topRate: TopRateView()
            case .news: NewsView()
            case .chat: ChatView()
            case .profile: ProfileView(isLoggedIn: isLoggedIn)
            }
        }
        
        var iconFill: ImageResource {
            switch self {
            case .dashboard: .homeFill
            case .topRate: .starFill
            case .news: .newsFill
            case .chat: .chatFill
            case .profile: .profileFill
            }
        }
        
        var iconOutline: ImageResource {
            switch self {
            case .dashboard: .homeOutline
            case .topRate: .starOutline
            case .news: .newsOutline
            case .chat: .chatOutline
            case .profile: .profileOutline
            }
        }
    }
}
