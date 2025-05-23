//
//  GoalSettingsViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI
import SwiftData

@Observable
final class GoalSettingsViewModel {
    @ObservationIgnored private let modelContext: ModelContext
    private var userSettings: UserSettings?

    var calorieGoal: String = ""
    var proteinGoal: String = ""
    var carbsGoal: String = ""
    var fatsGoal: String = ""

    init(modelContext: ModelContext, initialSettings: [UserSettings]) {
        self.modelContext = modelContext
        self.userSettings = initialSettings.first
        loadGoals()
    }

    var isValid: Bool {
        guard let c = Int(calorieGoal),
              let p = Int(proteinGoal),
              let carb = Int(carbsGoal),
              let f = Int(fatsGoal) else { return false }
        return c > 0 && p > 0 && carb > 0 && f > 0
    }

    func loadGoals() {
        let settings = userSettings ?? UserSettings()
        calorieGoal = String(settings.calorieGoal)
        proteinGoal = String(settings.proteinGoal)
        carbsGoal = String(settings.carbsGoal)
        fatsGoal = String(settings.fatsGoal)
    }

    func saveGoals() throws {
        let settings: UserSettings
        if let existing = userSettings {
            settings = existing
        } else {
            settings = UserSettings()
            modelContext.insert(settings)
        }

        settings.calorieGoal = Int(calorieGoal) ?? settings.calorieGoal
        settings.proteinGoal = Int(proteinGoal) ?? settings.proteinGoal
        settings.carbsGoal = Int(carbsGoal) ?? settings.carbsGoal
        settings.fatsGoal = Int(fatsGoal) ?? settings.fatsGoal

        try modelContext.save()
    }
}
