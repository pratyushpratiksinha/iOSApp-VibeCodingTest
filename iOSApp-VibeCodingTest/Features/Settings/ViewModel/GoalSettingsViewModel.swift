//
//  GoalSettingsViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
final class GoalSettingsViewModel {
    @ObservationIgnored private let modelContext: ModelContext
    private var userSettings: UserSettings?
    
    // MARK: - Published Properties
    var calorieGoal: String = ""
    var proteinGoal: String = ""
    var carbsGoal: String = ""
    var fatsGoal: String = ""
    var isLoading = false
    var errorMessage: String?
    var showError = false
    
    // Focus states
    var isCaloriesFocused = false
    var isProteinFocused = false
    var isCarbsFocused = false
    var isFatsFocused = false
    
    // MARK: - Validation
    private var calorieValue: Int? { Int(calorieGoal) }
    private var proteinValue: Int? { Int(proteinGoal) }
    private var carbsValue: Int? { Int(carbsGoal) }
    private var fatsValue: Int? { Int(fatsGoal) }
    
    var isValid: Bool {
        guard let c = calorieValue,
              let p = proteinValue,
              let carb = carbsValue,
              let f = fatsValue else { return false }
        
        return c >= AppConstants.Nutrients.MinValue.Calories && c <= AppConstants.Nutrients.MaxValue.Calories &&
               p >= AppConstants.Nutrients.MinValue.Macro && p <= AppConstants.Nutrients.MaxValue.Protein &&
               carb >= AppConstants.Nutrients.MinValue.Macro && carb <= AppConstants.Nutrients.MaxValue.Carbs &&
               f >= AppConstants.Nutrients.MinValue.Macro && f <= AppConstants.Nutrients.MaxValue.Fats
    }
    
    var validationErrors: [String] {
        var errors: [String] = []
        
        if let c = calorieValue {
            if c < AppConstants.Nutrients.MinValue.Calories {
                errors.append("\(AppConstants.Nutrients.Titles.calories) must be at least \(AppConstants.Nutrients.MinValue.Calories) \(AppConstants.Nutrients.Units.calories)")
            } else if c > AppConstants.Nutrients.MaxValue.Calories {
                errors.append("\(AppConstants.Nutrients.Titles.calories) cannot exceed \(AppConstants.Nutrients.MaxValue.Calories) \(AppConstants.Nutrients.Units.calories)")
            }
        }
        
        if let p = proteinValue {
            if p < AppConstants.Nutrients.MinValue.Macro {
                errors.append("\(AppConstants.Nutrients.Titles.protein) must be at least \(AppConstants.Nutrients.MinValue.Macro)\(AppConstants.Nutrients.Units.protein)")
            } else if p > AppConstants.Nutrients.MaxValue.Protein {
                errors.append("\(AppConstants.Nutrients.Titles.protein) cannot exceed \(AppConstants.Nutrients.MaxValue.Protein)\(AppConstants.Nutrients.Units.protein)")
            }
        }
        
        if let carb = carbsValue {
            if carb < AppConstants.Nutrients.MinValue.Macro {
                errors.append("\(AppConstants.Nutrients.Titles.carbs) must be at least \(AppConstants.Nutrients.MinValue.Macro)\(AppConstants.Nutrients.Units.carbs)")
            } else if carb > AppConstants.Nutrients.MaxValue.Carbs {
                errors.append("\(AppConstants.Nutrients.Titles.carbs) cannot exceed \(AppConstants.Nutrients.MaxValue.Carbs)\(AppConstants.Nutrients.Units.carbs)")
            }
        }
        
        if let f = fatsValue {
            if f < AppConstants.Nutrients.MinValue.Macro {
                errors.append("\(AppConstants.Nutrients.Titles.fats) must be at least \(AppConstants.Nutrients.MinValue.Macro)\(AppConstants.Nutrients.Units.fats)")
            } else if f > AppConstants.Nutrients.MaxValue.Fats {
                errors.append("\(AppConstants.Nutrients.Titles.fats) cannot exceed \(AppConstants.Nutrients.MaxValue.Fats)\(AppConstants.Nutrients.Units.fats)")
            }
        }
        
        return errors
    }
    
    // MARK: - Initialization
    init(modelContext: ModelContext, initialSettings: [UserSettings]) {
        self.modelContext = modelContext
        self.userSettings = initialSettings.first
        loadGoals()
    }
    
    // MARK: - Public Methods
    func loadGoals() {
        let settings = userSettings ?? UserSettings()
        calorieGoal = String(settings.calorieGoal)
        proteinGoal = String(settings.proteinGoal)
        carbsGoal = String(settings.carbsGoal)
        fatsGoal = String(settings.fatsGoal)
    }
    
    func saveGoals() async throws {
        guard isValid else {
            throw GoalSettingsError.invalidInput(validationErrors)
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let settings: UserSettings
            if let existing = userSettings {
                settings = existing
            } else {
                settings = UserSettings()
                modelContext.insert(settings)
            }
            
            settings.calorieGoal = calorieValue ?? settings.calorieGoal
            settings.proteinGoal = proteinValue ?? settings.proteinGoal
            settings.carbsGoal = carbsValue ?? settings.carbsGoal
            settings.fatsGoal = fatsValue ?? settings.fatsGoal
            
            try modelContext.save()
        } catch {
            throw GoalSettingsError.saveFailed(error)
        }
    }
}

// MARK: - Error Handling
enum GoalSettingsError: LocalizedError {
    case invalidInput([String])
    case saveFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidInput(let errors):
            return errors.joined(separator: "\n")
        case .saveFailed(let error):
            return "Failed to save goals: \(error.localizedDescription)"
        }
    }
}
