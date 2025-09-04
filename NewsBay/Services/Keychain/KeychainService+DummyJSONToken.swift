//
//  KeychainService+DummyJSONToken.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation


// MARK: - STATIC VALUE IDENTIFIERS
extension KeychainService {
    static var jwtServiceIdentifier: String { "com.dummyjson.auth" }
    static var accessTokenIdentifier: String { "accessToken" }
    static var refreshTokenIdentifier: String { "refreshToken" }
}


// MARK: - ACCESS TOKEN
extension KeychainService {
    static func getDummyJSONAccessToken() throws(KeychainError) -> String? {
        guard let tokenData = KeychainService.read(service: jwtServiceIdentifier, account: accessTokenIdentifier) else {
            return nil
        }
        guard let token = String(data: tokenData, encoding: .utf8) else {
            throw KeychainError.keyDecodeFailed
        }
        return token
    }
    static func setDummyJSONAccessToken(_ token: String) throws(KeychainError) {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.keyEncodeFailed
        }
        KeychainService.save(data, service: jwtServiceIdentifier, account: accessTokenIdentifier)
    }
    static func deleteDummyJSONAccessToken() {
        KeychainService.delete(service: jwtServiceIdentifier, account: accessTokenIdentifier)
    }
}


// MARK: - REFRESH TOKEN
extension KeychainService {
    static func getDummyJSONRefreshToken() throws(KeychainError) -> String? {
        guard let tokenData = KeychainService.read(service: jwtServiceIdentifier, account: refreshTokenIdentifier) else {
            return nil
        }
        guard let token = String(data: tokenData, encoding: .utf8) else {
            throw KeychainError.keyDecodeFailed
        }
        return token
    }
    static func setDummyJSONRefreshToken(_ token: String) throws(KeychainError) {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.keyEncodeFailed
        }
        KeychainService.save(data, service: jwtServiceIdentifier, account: refreshTokenIdentifier)
    }
    static func deleteDummyJSONRefreshToken() {
        KeychainService.delete(service: jwtServiceIdentifier, account: refreshTokenIdentifier)
    }
}
