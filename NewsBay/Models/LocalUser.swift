//
//  LocalUser.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation
import SwiftData


@Model
final class LocalUser {
    @Attribute(.unique) var id: Int
    var username: String
    
    init(
        id: Int,
        username: String,
    ) {
        self.id = id
        self.username = username
    }
}
