//
//  HistoryViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 04/06/25.
//

import Foundation

@Observable
final class HistoryViewModel {
    
    var visibleSectionCount = 10
    
    func groupedItems(_ items: [FoodItem]) -> [(key: String, value: [FoodItem])] {
        let grouped = Dictionary(grouping: items) {
            Calendar.current.startOfDay(for: $0.timestamp)
        }

        let sorted = grouped.sorted { $0.key > $1.key }

        return sorted.map { (key: DateFormatter.day.string(from: $0.key), value: $0.value) }
    }

    func summary(for items: [FoodItem], userSettings: UserSettings?) -> (consumed: (calories: Int, protein: Int, carbs: Int, fats: Int), goal: (calories: Int, protein: Int, carbs: Int, fats: Int)) {
        let consumed = (
            calories: items.reduce(0) { $0 + $1.calories },
            protein: items.reduce(0) { $0 + $1.protein },
            carbs: items.reduce(0) { $0 + $1.carbs },
            fats: items.reduce(0) { $0 + $1.fats }
        )

        let goal = (
            calories: userSettings?.calorieGoal ?? 2000,
            protein: userSettings?.proteinGoal ?? 100,
            carbs: userSettings?.carbsGoal ?? 250,
            fats: userSettings?.fatsGoal ?? 70
        )

        return (consumed: consumed, goal: goal)
    }
}
