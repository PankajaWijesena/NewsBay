//
//  View+CustomFont.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

extension Font {
    static func customFont(_ font: CustomFont, size: CGFloat) -> Font {
        Font.custom(font.rawValue, size: size)
    }
}

enum CustomFont: String {
    case lexend300 = "LexendDeca-Light"
    case lexend400 = "LexendDeca-Regular"
    case lexend500 = "LexendDeca-Medium"
    case lexend600 = "LexendDeca-SemiBold"
    case lexend700 = "LexendDeca-Bold"
}
