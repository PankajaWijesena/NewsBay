//
//  PostMetadataArea.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct PostMetadataArea: View {
    let emoji: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(emoji)
                .font(.customFont(.lexend300, size: 12))
            Text(text)
                .font(.customFont(.lexend300, size: 12))
                .foregroundStyle(Color.primary2)
        }
    }
}
