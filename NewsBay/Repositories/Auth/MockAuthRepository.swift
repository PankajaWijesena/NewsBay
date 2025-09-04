//
//  RemoteAuthRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class MockAuthRepository: AuthRepository {
    var testUser: User? = nil
    var testAuthToken: AuthToken? = nil
    
    func login(username: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        if let testUser {
            return testUser
        } else {
            throw AuthError.unknownError(NSError(domain: "Mock Login", code: 1))
        }
    }
    
    func signUp(username: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        if let testUser {
            return testUser
        } else {
            throw AuthError.unknownError(NSError(domain: "Mock Login", code: 1))
        }
    }
    
    func refreshAuthToken(with refreshToken: String) async throws -> AuthToken {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        if let testAuthToken {
            return testAuthToken
        } else {
            throw AuthError.unknownError(NSError(domain: "Mock Token Refresh", code: 1))
        }
    }
}
