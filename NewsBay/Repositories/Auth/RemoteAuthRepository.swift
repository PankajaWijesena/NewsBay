//
//  RemoteAuthRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class RemoteAuthRepository: AuthRepository {
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService(baseURL: Constant.API.baseURL)) {
        self.networkService = networkService
    }
    
    func login(username: String, password: String) async throws -> User {
        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        guard let httpBody: Data = try? JSONEncoder().encode(body) else {
            throw AuthError.unknownError(NSError(domain: "JSON Encoding Error", code: 1))
        }
        let userData: User = try await networkService.request(
            endpoint: "/auth/login",
            method: .POST,
            headers: [
                "Content-Type": "application/json"
            ],
            body: httpBody,
            queryItems: nil
        )
        return userData
    }
    
    func signUp(username: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        let userData = User(
            id: UUID().hashValue,
            username: username,
            accessToken: UUID().uuidString,
            refreshToken: UUID().uuidString
        )
        return userData
    }
    
    func refreshAuthToken(with refreshToken: String) async throws -> AuthToken {
        let body: [String: String] = [
            "refreshToken": refreshToken
        ]
        guard let httpBody: Data = try? JSONEncoder().encode(body) else {
            throw AuthError.unknownError(NSError(domain: "JSON Encoding Error", code: 1))
        }
        let tokenData: AuthToken = try await networkService.request(
            endpoint: "/auth/refresh",
            method: .POST,
            headers: [
                "Content-Type": "application/json"
            ],
            body: httpBody,
            queryItems: nil
        )
        return tokenData
    }
}
