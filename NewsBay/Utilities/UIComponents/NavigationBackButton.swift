//
//  NavigationBackButton.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var tint: Color = Color.secondary

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.chevron)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(tint)
                .scaledToFit()
                .frame(width: 16, height: 16)
        }
    }
}
