//
//  SearchField.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct SearchField: View {
    @Binding var query: String
    let placeholder: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(.magnify)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.secondary)
                .scaledToFit()
                .frame(width: 14, height: 14)
            TextField(placeholder, text: $query)
                .font(.customFont(.lexend300, size: 12))
        }
        .inputFieldStyle()
        .clipShape(.capsule)
    }
}
