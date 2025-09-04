//
//  PrimaryButton.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.customFont(.lexend600, size: 14))
                .foregroundStyle(Color.customWhite)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.customBlue)
                .clipShape(.capsule)
        }
    }
}
