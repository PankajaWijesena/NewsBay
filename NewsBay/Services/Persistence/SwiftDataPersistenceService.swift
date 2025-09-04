//
//  SwiftDataPersistenceService.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation
import SwiftData

final class SwiftDataPersistenceService: ObservableObject, PersistenceServicing {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveUser(_ user: LocalUser) throws(PersistenceError) {
        context.insert(user)
        do {
            try context.save()
        } catch {
            throw PersistenceError.userSaveFailed(error)
        }
    }
    
    func fetchUser() throws(PersistenceError) -> LocalUser {
        let descriptor = FetchDescriptor<LocalUser>()
        guard let users: [LocalUser] = try? context.fetch(descriptor) else {
            throw PersistenceError.unknownError(message: "SwiftData fetch failed")
        }
        guard let user = users.first else {
            throw PersistenceError.userNotFound
        }
        return user
    }
    
    func removeUser() throws(PersistenceError) {
        let descriptor = FetchDescriptor<LocalUser>()
        guard let users: [LocalUser] = try? context.fetch(descriptor) else {
            throw PersistenceError.unknownError(message: "SwiftData fetch failed")
        }
        guard let user = users.first else {
            throw PersistenceError.userNotFound
        }
        context.delete(user)
        do {
            try context.save()
        } catch {
            throw PersistenceError.unknownError(message: "SwiftData save failed")
        }
    }
}
