//
//  ContentView.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var persistenceService: SwiftDataPersistenceService
    @State private var isCheckingLoginStatus: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            if isLoggedIn {
                MainTabView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .opacity(isCheckingLoginStatus ? 0 : 1)
        .task {
            checkLoginStatus()
        }
    }
}

extension ContentView {
    func checkLoginStatus() {
        isCheckingLoginStatus = true
        do {
            _ = try persistenceService.fetchUser()
            isLoggedIn = true
        } catch {
            switch error {
            case PersistenceError.userNotFound:
                print("No local user found, continuing with login")
            default:
                print("Unknown error: \(error)")
            }
            isLoggedIn = false
        }
        isCheckingLoginStatus = false
    }
}

#Preview("Content View") {
    ContentView()
        .preferredColorScheme(.light)
}
