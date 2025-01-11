//
//  AppEntry.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 08/01/2025.
//

import SwiftUI
import SwiftData

@main
struct AppEntry: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteLocation.self
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
            AppLayout()
        }
        .modelContainer(sharedModelContainer)
    }
}
