//
//  Post.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let reactions: Reactions
    let views: Int
    let userId: Int
}

extension Post {
    struct Reactions: Codable {
        let likes: Int
        let dislikes: Int
    }
}
