//
//  AvatarPlaceholder.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct AvatarPlaceholder: View {
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color

    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(foregroundColor)
            Text(text)
                .foregroundStyle(backgroundColor)
        }
    }
}
