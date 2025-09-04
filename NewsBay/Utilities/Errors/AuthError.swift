//
//  AuthError.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .unknownError(let message):
            "Failed: \(message)"
        }
    }
}
