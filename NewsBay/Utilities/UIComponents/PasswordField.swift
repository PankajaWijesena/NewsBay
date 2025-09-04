//
//  PasswordField.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    let placeholder: String
    @State private var isVisible: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if isVisible {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            Button{
                isVisible.toggle()
            } label: {
                Image(isVisible ? .visibilityOff : .visibilityOn)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.secondary)
                    .scaledToFit()
                    .frame(height: 16)
            }
        }
        .inputFieldStyle()
        .clipShape(.rect(cornerRadius: 10))
    }
}
