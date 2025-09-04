//
//  TopRateView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct TopRateView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Top Rate Screen")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Top Rate")
    }
}

#Preview("Top Rate") {
    TopRateView()
        .preferredColorScheme(.light)
}
