//
//  LoginBanner.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct LoginBanner: View {
    var body: some View {
        Color.bannerGradient
            .ignoresSafeArea(edges: .top)
            .overlay(alignment: .bottom) {
                VStack(alignment: .center, spacing: 4) {
                    Image(.notesText)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.customWhite)
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("NewsBay")
                        .font(.customFont(.lexend500, size: 22))
                        .foregroundStyle(Color.customWhite)
                }
                .padding(.bottom, 28)
            }
    }
}
