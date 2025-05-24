//
//  AnalysisViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation

@Observable
final class AnalysisViewModel {
    func groupedItems(_ items: [FoodItem]) -> [(key: String, value: [FoodItem])] {
        let grouped = Dictionary(grouping: items) {
            DateFormatter.day.string(from: $0.timestamp)
        }
        return grouped.sorted { $0.key > $1.key }
    }

    func dailyCalories(for items: [FoodItem]) -> [Date: Int] {
        Dictionary(grouping: items, by: { $0.timestamp.onlyDate })
            .mapValues { $0.reduce(0) { $0 + $1.calories } }
    }

    func macroDistribution(for items: [FoodItem]) -> (protein: Int, carbs: Int, fats: Int) {
        let total = items.reduce((protein: 0, carbs: 0, fats: 0)) { acc, item in
            (acc.protein + item.protein, acc.carbs + item.carbs, acc.fats + item.fats)
        }
        return total
    }
    
    func summary(for items: [FoodItem], userSettings: UserSettings?) -> (consumed: (calories: Int, protein: Int, carbs: Int, fats: Int), goal: (calories: Int, protein: Int, carbs: Int, fats: Int)) {
        let consumed = (
            calories: items.reduce(0) { $0 + $1.calories },
            protein:  items.reduce(0) { $0 + $1.protein },
            carbs:    items.reduce(0) { $0 + $1.carbs },
            fats:     items.reduce(0) { $0 + $1.fats }
        )

        let goal = (
            calories: userSettings?.calorieGoal ?? 2000,
            protein:  userSettings?.proteinGoal ?? 100,
            carbs:    userSettings?.carbsGoal ?? 250,
            fats:     userSettings?.fatsGoal ?? 70
        )

        return (consumed: consumed, goal: goal)
    }
}
