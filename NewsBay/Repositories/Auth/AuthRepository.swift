//
//  AuthRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String) async throws -> User
    func signUp(username: String, password: String) async throws -> User
    func refreshAuthToken(with refreshToken: String) async throws -> AuthToken
}
