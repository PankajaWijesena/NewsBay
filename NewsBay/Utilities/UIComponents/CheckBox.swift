//
//  CheckBox.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct CheckBox: View {
    @Binding var value: Bool
    let title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button {
                value.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(value ? Color.primary1 : .clear)
                    .strokeBorder(
                        value ? Color.primary1 : Color.secondary,
                        lineWidth: 1
                    )
                    .frame(width: 16, height: 16)
                    .overlay(alignment: .center) {
                        Image(systemName: "checkmark")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(value ? Color.customWhite : .clear)
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                    }
            }
            Text(title)
                .font(.customFont(.lexend300, size: 12))
        }
        .foregroundStyle(Color.onSurface)
       
    }
}
