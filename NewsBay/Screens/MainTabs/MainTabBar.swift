//
//  MainTabView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension MainTabView {
    struct TabBar: View {
        @Binding var selected: TabItem
        
        var body: some View {
            HStack(spacing: 0) {
                ForEach(TabItem.allCases, id: \.self) { tab in
                    TabCell(
                        tab: tab,
                        selected: $selected,
                        icon: (fill: tab.iconFill, outline: tab.iconOutline)
                    )
                    if tab != TabItem.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background {
                Rectangle()
                    .fill(Color.clear)
                    .background(Color.customWhite)
                    .ignoresSafeArea(edges: .bottom)
                    .compositingGroup()
                    .shadow(
                        color: Color.black.opacity(0.04),
                        radius: 4,
                        x: 0,
                        y: -4
                    )
            }
        }
    }
}
