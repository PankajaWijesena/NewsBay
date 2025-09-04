//
//  ProfileViewModel.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class ProfileViewModel: BaseViewModel {
    func logOut(persistence: PersistenceServicing) throws {
        guard (try? persistence.fetchUser()) != nil else {
            print("No saved local user found.")
            return
        }
        try persistence.removeUser()
        KeychainService.deleteDummyJSONAccessToken()
        KeychainService.deleteDummyJSONRefreshToken()
    }
}
