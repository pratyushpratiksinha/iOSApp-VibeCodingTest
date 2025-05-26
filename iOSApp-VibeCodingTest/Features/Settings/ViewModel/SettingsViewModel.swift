//
//  SettingsViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI
import SwiftData

@MainActor
final class SettingsViewModel {
    @Binding var username: String
    private let modelContext: ModelContext

    init(username: Binding<String>, context: ModelContext) {
        _username = username
        self.modelContext = context
    }

    var displayName: String {
        username
    }

    func logout() throws {
        try modelContext.delete(model: FoodItem.self)
        try modelContext.delete(model: UserSettings.self)
        try modelContext.save()

        username = ""
    }
}
