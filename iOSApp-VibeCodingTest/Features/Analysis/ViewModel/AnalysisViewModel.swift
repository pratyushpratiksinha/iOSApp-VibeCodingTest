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
    
    var selectedRangeForCalorieTrend: TimeRange = .oneDay
    var selectedRangeForMacroDistribution: TimeRange = .oneDay

    func filteredItems(_ items: [FoodItem], for range: TimeRange) -> [FoodItem] {
        switch range {
        case .oneDay:
            let calendar = Calendar.current
            let startOfToday = calendar.startOfDay(for: Date())
            let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
            return items.filter {
                $0.timestamp >= startOfToday && $0.timestamp < startOfTomorrow
            }

        default:
            let cutoffDate = Calendar.current.date(byAdding: .day, value: -range.days, to: Date()) ?? Date()
            return items.filter { $0.timestamp >= cutoffDate }
        }
    }

    func caloriesDistribution(for items: [FoodItem]) -> [Date: Int] {
        Dictionary(grouping: items, by: { $0.timestamp.onlyDate })
            .mapValues { $0.reduce(0) { $0 + $1.calories } }
    }

    func macroDistribution(for items: [FoodItem]) -> (protein: Int, carbs: Int, fats: Int) {
        let total = items.reduce((protein: 0, carbs: 0, fats: 0)) { acc, item in
            (acc.protein + item.protein, acc.carbs + item.carbs, acc.fats + item.fats)
        }
        return total
    }
    
    func stackedMacroDistribution(for items: [FoodItem]) -> [Date: (protein: Int, carbs: Int, fats: Int)] {
        let grouped = Dictionary(grouping: items, by: { $0.timestamp.onlyDate })

        return grouped.mapValues { group in
            let total = group.reduce((protein: 0, carbs: 0, fats: 0)) { acc, item in
                (
                    acc.protein + item.protein,
                    acc.carbs + item.carbs,
                    acc.fats + item.fats
                )
            }
            return total
        }
    }
}
