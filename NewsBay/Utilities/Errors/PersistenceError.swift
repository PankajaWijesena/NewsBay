//
//  PersistenceError.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum PersistenceError: Error, LocalizedError {
    case userNotFound
    case userSaveFailed(Error)
    case userRemoveFailed(Error)
    case unknownError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .userNotFound: "No local user found"
        case .userSaveFailed(_): "Failed saving local user"
        case .userRemoveFailed(_): "Failed removing local user"
        case .unknownError(_): "Unknown error occurred"
        }
    }
}
