//
//  AnalysisViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation

@Observable
final class AnalysisViewModel {
    
    enum TimeRange: String, CaseIterable, Identifiable {
        case oneDay = "1D"
        case oneWeek = "1W"
        case twoWeeks = "2W"
        case threeWeeks = "3W"
        case oneMonth = "1M"
        
        var id: String { rawValue }
        
        var days: Int {
            switch self {
            case .oneDay: return 1
            case .oneWeek: return 7
            case .twoWeeks: return 14
            case .threeWeeks: return 21
            case .oneMonth: return 30
            }
        }
    }
    
    var visibleSectionCount = 10
    var selectedRange: TimeRange = .oneDay

    func filteredItems(_ items: [FoodItem], for range: TimeRange) -> [FoodItem] {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -range.days, to: Date()) ?? Date()
        return items.filter { $0.timestamp >= cutoffDate }
    }
    
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
