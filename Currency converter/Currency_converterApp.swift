//
//  Currency_converterApp.swift
//  Currency converter
//
//  Created by Leonid Safronov on 19.01.2024.
//

import SwiftUI
import SwiftData

@main
struct Currency_converterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CurrencyStorage.self,
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
