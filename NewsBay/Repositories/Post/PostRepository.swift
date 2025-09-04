//
//  PostRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

protocol PostRepository {
    func fetchAllPosts(skip: Int) async throws -> [Post]
    func searchPosts(query: String, skip: Int) async throws -> [Post]
}
