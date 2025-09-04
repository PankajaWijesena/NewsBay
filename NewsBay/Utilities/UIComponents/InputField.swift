//
//  InputField.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .inputFieldStyle()
            .clipShape(.rect(cornerRadius: 10))
    }
}
