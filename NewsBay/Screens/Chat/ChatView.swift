//
//  ChatView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Chat Screen")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Chat")
    }
}

#Preview("Chat") {
    ChatView()
        .preferredColorScheme(.light)
}
