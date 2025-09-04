//
//  MockPersistenceService.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class MockPersistenceService: PersistenceServicing {
    private var localUser: LocalUser? = nil
    
    func saveUser(_ user: LocalUser) throws(PersistenceError) {
        localUser = user
    }
    
    func fetchUser() throws(PersistenceError) -> LocalUser {
        guard let localUser else {
            throw PersistenceError.userNotFound
        }
        return localUser
    }
    
    func removeUser() throws(PersistenceError) {
        guard localUser != nil else {
            throw PersistenceError.userNotFound
        }
        localUser = nil
    }
}
