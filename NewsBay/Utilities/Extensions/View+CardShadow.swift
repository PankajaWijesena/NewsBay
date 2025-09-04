//
//  View+CardShadow.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension View {
    func cardShadow(
        color: Color = .black.opacity(0.1),
        radius: CGFloat = 8,
        x: CGFloat = 0,
        y: CGFloat = 4
    ) -> some View {
        self.modifier(CardShadow(color: color, radius: radius, x: x, y: y))
    }
}

private struct CardShadow: ViewModifier {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .compositingGroup()
            .shadow(
                color: color,
                radius: radius,
                x: x,
                y: y
            )
    }
}
