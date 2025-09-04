//
//  NewsBayApp.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import SwiftUI
import SwiftData

@main
struct NewsBayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LocalUser.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(
                    SwiftDataPersistenceService(
                        context: sharedModelContainer.mainContext
                    )
                )
        }
    }
}


