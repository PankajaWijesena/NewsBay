//
//  KeychainError.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum KeychainError: Error, LocalizedError {
    case keyUnavailable
    case keyEncodeFailed
    case keyDecodeFailed
}
