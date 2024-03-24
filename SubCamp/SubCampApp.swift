//
//  SubCampApp.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 15.03.24.
//

import SwiftUI
import SwiftData

@main
struct SubCampApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Contract.self,
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
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
