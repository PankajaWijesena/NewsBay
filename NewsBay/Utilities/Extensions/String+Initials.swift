//
//  String+Initials.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

extension String {
    func getInitials() -> Self {
        self
            .split(separator: " ")
            .map { $0.first ?? " " }
            .map { $0.uppercased() }
            .joined()
    }
}
