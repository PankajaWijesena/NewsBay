//
//  PersistenceTests.swift
//  NewsBayTests
//
//  Created by Pankaja Wijesena.
//

import NewsBay
import SwiftData
import XCTest

final class PersistenceTests: XCTestCase {

    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var persistence: SwiftDataPersistenceService!

    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(
            for: LocalUser.self,
            configurations: config
        )
        modelContext = ModelContext(modelContainer)
        persistence = SwiftDataPersistenceService(context: modelContext)
    }

    
    override func tearDownWithError() throws {
        modelContainer = nil
        modelContext = nil
        persistence = nil
        try super.tearDownWithError()
    }

    
    func test_localUserSave_withValidLocalUser_SaveWithNoErrors() async throws {
        // GIVEN
        let user = LocalUser(id: UUID().hashValue, username: UUID().uuidString)

        // WHEN / THEN
        XCTAssertNoThrow(try persistence.saveUser(user))
    }
    
    
    func test_localUserFetch_withSavedUser_FetchesSavedUser() async throws {
        // GIVEN
        let user = LocalUser(id: UUID().hashValue, username: UUID().uuidString)
        
        // WHEN
        try persistence.saveUser(user)
        
        // THEN
        XCTAssertNoThrow(_ = try persistence.fetchUser())
    }
    
    
    func test_localUserSave_withValidLocalUser_PersistsExactlyOneUser() async throws {
        // GIVEN
        let user = LocalUser(id: UUID().hashValue, username: UUID().uuidString)
        
        // WHEN
        try persistence.saveUser(user)
        let descriptor = FetchDescriptor<LocalUser>()
        let savedUsers: [LocalUser] = try modelContext.fetch(descriptor)
        
        // THEN
        XCTAssertEqual(savedUsers.count, 1)
    }
    
    
    func test_localUserSave_withValidLocalUser_PersistedInStorage() async throws {
        // GIVEN
        let user = LocalUser(id: UUID().hashValue, username: UUID().uuidString)
        
        // WHEN
        try persistence.saveUser(user)
        let savedUser = try persistence.fetchUser()
        
        // THEN
        XCTAssertEqual(savedUser.id, user.id)
        XCTAssertEqual(savedUser.username, user.username)
    }
    
    
    func test_localUserRemove_withSavedUser_RemovesSavedUser() async throws {
        // GIVEN
        let user = LocalUser(id: UUID().hashValue, username: UUID().uuidString)
        
        // WHEN
        try persistence.saveUser(user)
        try persistence.removeUser()
        
        // THEN
        await XCTAssertThrowsErrorAsync(try self.persistence.fetchUser()) { error in
            XCTAssertTrue(error is PersistenceError)
            switch error as? PersistenceError {
            case .userNotFound:
                break
            default:
                XCTFail()
            }
        }
    }
}
