//
//  HomeViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import SwiftData

@Observable
final class HomeViewModel {
    var allFoods: [FoodItem] = []
    var userSettings: [UserSettings] = []
    var selectedDate: DateSelection = .today {
        didSet { updateForSelectedDate() }
    }

    var showCamera = false
    var editingFood: FoodItem?
    var foodsToday: [FoodItem] = []
    var calorieGoal: Int = 2000
    var proteinGoal: Int = 100
    var carbsGoal: Int = 250
    var fatsGoal: Int = 70
    var caloriesConsumed: Int = 0
    var caloriesLeft: Int = 0
    var proteinConsumed: Int = 0
    var proteinLeft: Int = 0
    var carbsConsumed: Int = 0
    var carbsLeft: Int = 0
    var fatsConsumed: Int = 0
    var fatsLeft: Int = 0

    var caloriesOver: Int? {
        caloriesLeft < 0 ? abs(caloriesLeft) : nil
    }

    var proteinOver: Int? {
        proteinLeft < 0 ? abs(proteinLeft) : nil
    }

    var carbsOver: Int? {
        carbsLeft < 0 ? abs(carbsLeft) : nil
    }

    var fatsOver: Int? {
        fatsLeft < 0 ? abs(fatsLeft) : nil
    }

    init(allFoods: [FoodItem], userSettings: [UserSettings], selectedDate: DateSelection = .today) {
        self.allFoods = allFoods
        self.userSettings = userSettings
        self.selectedDate = selectedDate
        updateForSelectedDate()
    }

    func updateInputs(allFoods: [FoodItem], userSettings: [UserSettings]) {
        self.allFoods = allFoods
        self.userSettings = userSettings
        updateForSelectedDate()
    }

    private func updateForSelectedDate() {
        // Get user goals
        let settings = userSettings.first
        calorieGoal = settings?.calorieGoal ?? 2000
        proteinGoal = settings?.proteinGoal ?? 100
        carbsGoal = settings?.carbsGoal ?? 250
        fatsGoal = settings?.fatsGoal ?? 70

        // Filter foods for selected date
        let calendar = Calendar.current
        let now = Date()
        let targetDate: Date = selectedDate == .today ? now : calendar.date(byAdding: .day, value: -1, to: now) ?? now
        foodsToday = allFoods.filter { calendar.isDate($0.timestamp, inSameDayAs: targetDate) }

        // Calculate totals
        let totalCalories = foodsToday.reduce(0) { $0 + $1.calories }
        let totalProtein = foodsToday.reduce(0) { $0 + $1.protein }
        let totalCarbs = foodsToday.reduce(0) { $0 + $1.carbs }
        let totalFats = foodsToday.reduce(0) { $0 + $1.fats }

        caloriesConsumed = totalCalories
        caloriesLeft = calorieGoal - totalCalories
        proteinConsumed = totalProtein
        proteinLeft = proteinGoal - totalProtein
        carbsConsumed = totalCarbs
        carbsLeft = carbsGoal - totalCarbs
        fatsConsumed = totalFats
        fatsLeft = fatsGoal - totalFats
    }

    enum DateSelection: String, CaseIterable {
        case today = "Today"
        case yesterday = "Yesterday"
    }
}
