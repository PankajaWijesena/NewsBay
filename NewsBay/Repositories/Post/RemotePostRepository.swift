//
//  RemotePostRepository.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class RemotePostRepository: PostRepository {
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService(baseURL: Constant.API.baseURL)) {
        self.networkService = networkService
    }
    
    func fetchAllPosts(skip: Int) async throws -> [Post] {
        let postResponse: PostsResponse = try await networkService.request(
            endpoint: "/posts",
            method: .GET,
            headers: [
                "Content-Type": "application/json"
            ],
            body: nil,
            queryItems: [
                "limit": "\(Constant.API.paginationLimit)",
                "skip": "\(skip)"
            ]
        )
        let posts = postResponse.posts
        return posts
    }
    
    func searchPosts(query: String, skip: Int) async throws -> [Post] {
        let postResponse: PostsResponse = try await networkService.request(
            endpoint: "/posts/search",
            method: .GET,
            headers: [
                "Content-Type": "application/json"
            ],
            body: nil,
            queryItems: [
                "q": query,
                "limit": "\(Constant.API.paginationLimit)",
                "skip": "\(skip)",
            ]
        )
        let posts = postResponse.posts
        return posts
    }
}
