//
//  PersistenceServicing.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

protocol PersistenceServicing {
    func saveUser(_ user: LocalUser) throws(PersistenceError)
    func fetchUser() throws(PersistenceError) -> LocalUser
    func removeUser() throws(PersistenceError)
}
