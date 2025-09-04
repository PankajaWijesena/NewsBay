//
//  KeychainServiceTests.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import XCTest
import NewsBay

final class KeychainServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        KeychainService.deleteDummyJSONAccessToken()
        KeychainService.deleteDummyJSONRefreshToken()
    }
    
    
    override func tearDown() {
        KeychainService.deleteDummyJSONAccessToken()
        KeychainService.deleteDummyJSONRefreshToken()
        super.tearDown()
    }
    
    
    func test_setDummyJSONAccessToken_validToken_tokenSavedAndRetrieved() throws {
        // GIVEN
        let token = "dummyAccessToken123"
        
        // WHEN
        try KeychainService.setDummyJSONAccessToken(token)
        let retrieved = try KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertNotNil(retrieved)
        XCTAssertEqual(retrieved, token)
    }
    
    
    func test_setDummyJSONRefreshToken_validToken_tokenSavedAndRetrieved() throws {
        // GIVEN
        let token = "dummyRefreshToken456"
        
        // WHEN
        try KeychainService.setDummyJSONRefreshToken(token)
        let retrieved = try KeychainService.getDummyJSONRefreshToken()
        
        // THEN
        XCTAssertNotNil(retrieved)
        XCTAssertEqual(retrieved, token)
    }
    
    
    func test_delete_accessTokenPreviouslySaved_tokenRemoved() throws {
        // GIVEN
        let token = "toBeDeletedAccessToken"
        
        // WHEN
        try KeychainService.setDummyJSONAccessToken(token)
        KeychainService.deleteDummyJSONAccessToken()
        let retrieved = try KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertNil(retrieved)
    }
    
    
    func test_delete_refreshTokenPreviouslySaved_tokenRemoved() throws {
        // GIVEN
        let token = "toBeDeletedRefreshToken"
        
        // WHEN
        try KeychainService.setDummyJSONRefreshToken(token)
        KeychainService.deleteDummyJSONRefreshToken()
        let retrieved = try KeychainService.getDummyJSONRefreshToken()
        
        // THEN
        XCTAssertNil(retrieved)
    }
    
    
    func test_getDummyJSONAccessToken_noTokenSaved_returnsNil() throws {
        // GIVEN / WHEN
        let retrieved = try KeychainService.getDummyJSONAccessToken()
        
        // THEN
        XCTAssertNil(retrieved)
    }
    
    
    func test_getDummyJSONRefreshToken_noTokenSaved_returnsNil() throws {
        // GIVEN / WHEN
        let retrieved = try KeychainService.getDummyJSONRefreshToken()
        
        // THEN
        XCTAssertNil(retrieved)
    }
}
