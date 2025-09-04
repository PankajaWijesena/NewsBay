//
//  MainTabView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

extension MainTabView {
    final class TabState: ObservableObject {
        @Published var selectedTab: TabItem
        
        init(selectedTab: TabItem = .dashboard) {
            self.selectedTab = selectedTab
        }
    }
}
