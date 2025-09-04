//
//  NewsView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("News Screen")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("News")
    }
}

#Preview("News") {
    NewsView()
        .preferredColorScheme(.light)
}
