//
//  SignUpViewModel.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class SignUpViewModel: BaseViewModel {
    private let repository: AuthRepository
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    init(repository: AuthRepository) {
        self.repository = repository
        super.init()
    }
    
    @discardableResult
    func performSignUp(persistence: PersistenceServicing) async throws -> User {
        try validateCredtionals()
        let userData: User = try await repository.signUp(
            username: username,
            password: password,
        )
        let localUser = LocalUser(
            id: userData.id,
            username: userData.username,
        )
        try persistence.saveUser(localUser)
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
