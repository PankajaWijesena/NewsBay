//
//  PostsSectionHeader.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//


import SwiftUI

struct PostsSectionHeader: View {
    let title: String
    let viewAllAction: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.customFont(.lexend500, size: 18))
                .foregroundStyle(Color.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextButton(
                title: "View All",
                action: viewAllAction,
            )
            .font(.customFont(.lexend400, size: 14))
            .foregroundStyle(Color.primary1)
        }
    }
}
