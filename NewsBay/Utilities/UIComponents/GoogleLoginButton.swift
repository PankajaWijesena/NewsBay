//
//  GoogleLoginButton.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct GoogleLoginButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8) {
                Image(.google)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Text("Login with Google")
                    .font(.customFont(.lexend500, size: 14))
                    .foregroundStyle(Color.secondary)
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(.capsule)
            .overlay {
                Capsule()
                    .stroke(Color.line, lineWidth: 1)
            }
        }
    }
}
