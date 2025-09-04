//
//  User.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let accessToken: String
    let refreshToken: String
}
