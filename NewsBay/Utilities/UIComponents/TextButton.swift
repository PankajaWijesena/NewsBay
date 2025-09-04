//
//  TextButton.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct TextButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .background {
                    Rectangle()
                        .fill(Color.black.opacity(0.001))
                }
        }
    }
}
