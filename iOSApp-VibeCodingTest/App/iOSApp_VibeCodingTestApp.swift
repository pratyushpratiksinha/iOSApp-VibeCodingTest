//
//  iOSApp_VibeCodingTestApp.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI
import SwiftData

@main
struct iOSApp_VibeCodingTestApp: App {
    
    @AppStorage(AppStorageKeys.username) private var username: String = ""

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
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
            if username.isEmpty {
                LoginView()
            } else {
                MainTabView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
