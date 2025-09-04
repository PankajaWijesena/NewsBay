//
//  AuthToken.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
}
