//
//  LoginViewModel.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    private let repository: AuthRepository
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var rememberUser = false

    init(repository: AuthRepository) {
        self.repository = repository
    }

    @discardableResult
    func performLogin(persistence: PersistenceServicing) async throws -> User {
        try validateCredtionals()
        let userData: User = try await repository.login(
            username: username,
            password: password,
        )
        if rememberUser {
            let localUser = LocalUser(
                id: userData.id,
                username: userData.username,
            )
            try KeychainService.setDummyJSONAccessToken(userData.accessToken)
            try KeychainService.setDummyJSONRefreshToken(userData.refreshToken)
            try persistence.saveUser(localUser)
        }
        return userData
    }
    
    private func validateCredtionals() throws(LoginValidationError) {
        if username.isEmpty {
            throw LoginValidationError.usernameEmpty
        }
        if password.isEmpty {
            throw LoginValidationError.passwordEmpty
        }
        if password.count < 8 {
            throw LoginValidationError.passwordTooShort
        }
    }
}
