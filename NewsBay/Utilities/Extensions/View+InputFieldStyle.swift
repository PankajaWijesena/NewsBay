//
//  View+InputFieldStyle.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension View {
    func inputFieldStyle() -> some View {
        self.modifier(InputFieldStyle())
    }
}

private struct InputFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.customFont(.lexend300, size: 14))
            .foregroundStyle(Color.onSurface)
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(Color.inputFieldBackground)
    }
}
