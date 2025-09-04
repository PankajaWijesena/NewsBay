//
//  MockPostRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class MockPostRepository: PostRepository {
    var allPostsToReturn: [Post] = []
    var searchPostsToReturn: [Post] = []
    
    func fetchAllPosts(skip: Int) async throws -> [Post] {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        return allPostsToReturn
    }
    
    func searchPosts(query: String, skip: Int) async throws -> [Post] {
        try await Task.sleep(for: .seconds(1))  // SIMIULATED NETWORK CALL
        return searchPostsToReturn
    }
}
