//
//  AuthenticationTests.swift
//  NewsBayTests
//
//  Created by Pankaja Wijesena.
//

import XCTest
import NewsBay

final class AuthenticationTests: XCTestCase {
    
    var repository: MockAuthRepository!
    var persistenceService: MockPersistenceService!
    var expectedUser: User!
    var username: String!
    var password: String!
    
    override func setUp() {
        super.setUp()
        repository = MockAuthRepository()
        persistenceService = MockPersistenceService()
        expectedUser = User(
            id: UUID().hashValue,
            username: UUID().uuidString,
            accessToken: UUID().uuidString,
            refreshToken: UUID().uuidString
        )
        username = UUID().uuidString
        password = UUID().uuidString
        KeychainService.deleteDummyJSONAccessToken()
    }
    
    
    override func tearDown() {
        repository = nil
        persistenceService = nil
        expectedUser = nil
        username = nil
        password = nil
        KeychainService.deleteDummyJSONAccessToken()
        super.tearDown()
    }
    
    
    func test_login_withValidUserData_returnsExpectedUser() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        
        // WHEN
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
        }
        let user = try await viewModel.performLogin(persistence: persistenceService)
        
        // THEN
        XCTAssertEqual(user.username, expectedUser.username)
        XCTAssertEqual(user.accessToken, expectedUser.accessToken)
    }
    
    
    func test_login_withInvalidUserData_throwsAuthError() async {
        // GIVEN
        repository.testUser = nil
        let viewModel = await LoginViewModel(repository: repository)
        
        // WHEN
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
        }
        
        // THEN
        await XCTAssertThrowsErrorAsync(
            try await viewModel.performLogin(persistence: self.persistenceService)
        ) { error in
            XCTAssertTrue(error is AuthError)
        }
    }
    
    
    func test_login_withInvalidCredentials_throwsValidationError() async {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            viewModel.username = ""
            viewModel.password = ""
        }
        
        // WHEN / THEN
        await XCTAssertThrowsErrorAsync(
            try await viewModel.performLogin(persistence: self.persistenceService)
        ) { error in
            XCTAssertTrue(error is LoginValidationError)
        }
    }
    
    
    func test_login_withValidDataAndRememberUser_persistsLocalUser() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
            viewModel.rememberUser = true
        }
        
        // WHEN
        try await viewModel.performLogin(persistence: persistenceService)
        let localUser = try persistenceService.fetchUser()
        
        // THEN
        XCTAssertEqual(localUser.username, expectedUser.username)
    }
    
    
    func test_login_withValidDataAndNotRememberUser_doesNotPersistLocalUser() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
            viewModel.rememberUser = false
        }
        
        // WHEN
        try await viewModel.performLogin(persistence: persistenceService)
        let localUser = try? persistenceService.fetchUser()
        
        // THEN
        XCTAssertNil(localUser)
    }
    
    
    func test_login_withValidDataAndRememberUser_persistsAccessToken() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
            viewModel.rememberUser = true
        }
        
        // WHEN
        try await viewModel.performLogin(persistence: persistenceService)
        let localSavedAccessToken = try KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertEqual(localSavedAccessToken, expectedUser.accessToken)
    }
    
    
    func test_login_withValidDataAndNotRememberUser_doesNotPersistsAccessToken() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let viewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            viewModel.username = username
            viewModel.password = password
            viewModel.rememberUser = false
        }
        
        // WHEN
        try await viewModel.performLogin(persistence: persistenceService)
        let localSavedAccessToken = try? KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertNil(localSavedAccessToken)
    }
    
    
    func test_logOut_whenLoggedInWithRememberUser_doesNotPersistLocalUser() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let loginViewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            loginViewModel.username = username
            loginViewModel.password = password
            loginViewModel.rememberUser = true
        }
        let profileViewModel = ProfileViewModel()
        
        
        // WHEN
        try await loginViewModel.performLogin(persistence: persistenceService)
        try profileViewModel.logOut(persistence: persistenceService)
        let localSavedAccessToken = try? KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertNil(localSavedAccessToken)
    }
    
    
    func test_logOut_whenLoggedInWithRememberUser_doesNotPersistAccessToken() async throws {
        // GIVEN
        repository.testUser = expectedUser
        let loginViewModel = await LoginViewModel(repository: repository)
        await MainActor.run {
            loginViewModel.username = username
            loginViewModel.password = password
            loginViewModel.rememberUser = true
        }
        let profileViewModel = ProfileViewModel()
        
        
        // WHEN
        try await loginViewModel.performLogin(persistence: persistenceService)
        try profileViewModel.logOut(persistence: persistenceService)
        let localUser = try? persistenceService.fetchUser()
        
        // THEN
        XCTAssertNil(localUser)
    }
}
