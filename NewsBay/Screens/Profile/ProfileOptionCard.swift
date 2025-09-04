//
//  ProfileOptionCard.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct ProfileOptionCard: View {
    let icon: Image
    let title: String
    let iconColor: Color
    let textColor: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            icon
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(iconColor)
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text(title)
                .font(.customFont(.lexend400, size: 16))
                .foregroundStyle(textColor)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
