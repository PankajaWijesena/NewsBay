//
//  Color+Hex.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension Color {
    static let primary1 = Color(hex: "#48AC85")
    static let primary2 = Color(hex: "#123726")
    static let customWhite = Color(hex: "#FFFFFF")
    static let secondary = Color(hex: "#6C6C78")
    static let onSurface = Color(hex: "#141416")
    static let surface = Color(hex: "#F8F8F8")
    static let line = Color(hex: "#E5E5E5")
    static let critical = Color(hex: "#EB5A5A")
    static let warning = Color(hex: "#F6BE3C")
    static let success = Color(hex: "#348037")
    static let customBlue = Color(hex: "#2DC28D")
    static let inputFieldBackground = Color(hex: "#F5F5F5")
    
    static let bannerGradient = LinearGradient(
        gradient: Gradient(
            colors: [Color(hex: "#41AC85"), Color(hex: "#127970")]
        ),
        startPoint: .top,
        endPoint: .bottom
    )
    
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}
