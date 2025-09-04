//
//  MainTabView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var state = TabState()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            state.selectedTab.view(isLoggedIn: $isLoggedIn)
            TabBar(selected: $state.selectedTab)
        }
    }
}
