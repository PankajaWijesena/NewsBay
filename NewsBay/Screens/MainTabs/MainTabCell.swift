//
//  MainTabView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension MainTabView {
    struct TabCell: View {
        let tab: TabItem
        @Binding var selected: TabItem
        let icon: (fill: ImageResource, outline: ImageResource)
        
        var body: some View {
            VStack(spacing: 0) {
                Image(tab == selected ? icon.fill : icon.outline)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                
                Spacer(minLength: 0)
                
                Text(tab.rawValue)
                    .font(.customFont(.lexend300, size: 12))
            }
            .foregroundStyle(selected == tab ? Color.primary1 : Color.secondary)
            .frame(width: 52, height: 40)
            .onTapGesture {
                withAnimation {
                    selected = tab
                }
            }
        }
    }
}
