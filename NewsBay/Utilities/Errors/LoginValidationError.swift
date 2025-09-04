//
//  LoginValidationError.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum LoginValidationError: Error, LocalizedError {
    case usernameEmpty
    case passwordEmpty
    case passwordTooShort
    
    var errorDescription: String? {
        switch self {
        case .usernameEmpty:
            "Username is empty."
        case .passwordEmpty:
            "Password is empty."
        case .passwordTooShort:
            "Password is too short."
        }
    }
}
