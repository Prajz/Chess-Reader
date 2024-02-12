//
//  cApp.swift
//  c
//
//  Created by Dev Prajapati on 19/01/2024.
//

import SwiftUI
import SwiftData

@main
struct cApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Game.self,
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
        }
        .modelContainer(sharedModelContainer)
    }
}
