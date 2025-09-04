//
//  PostsResponse.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

struct PostsResponse: Codable {
    let posts: [Post]
    let total: Int
    let skip: Int
    let limit: Int
}
