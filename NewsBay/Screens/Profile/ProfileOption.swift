//
//  ProfileOption.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

enum ProfileOption: Identifiable, CaseIterable {
    case settings
    case friends
    case favourite
    case reviews
    case followers
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .settings: "Settings"
        case .friends: "My Friends"
        case .favourite: "My Favourite"
        case .reviews: "Latest Reviews"
        case .followers: "Followers"
        }
    }
    
    var image: Image {
        switch self {
        case .settings: Image(.settings)
        case .friends: Image(.friends)
        case .favourite: Image(.heart)
        case .reviews: Image(.starOutline)
        case .followers: Image(.wifi)
        }
    }
}
