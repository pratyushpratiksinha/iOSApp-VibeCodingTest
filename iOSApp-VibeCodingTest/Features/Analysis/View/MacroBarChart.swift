//
//  MacroBarChart.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI
import Charts

struct MacroBarChart: View {
    let data: (protein: Int, carbs: Int, fats: Int)

    var body: some View {
        let entries = [
            MacroEntry(name: Constants.proteinLabel, value: data.protein, color: Constants.proteinColor),
            MacroEntry(name: Constants.carbsLabel, value: data.carbs, color: Constants.carbsColor),
            MacroEntry(name: Constants.fatsLabel, value: data.fats, color: Constants.fatsColor)
        ]

        Chart(entries) { entry in
            BarMark(
                x: .value(Constants.xAxisLabel, entry.name),
                y: .value(Constants.yAxisLabel, entry.value)
            )
            .foregroundStyle(entry.color)
        }
    }

    private enum Constants {
        static let proteinLabel = "Protein"
        static let carbsLabel = "Carbs"
        static let fatsLabel = "Fats"
        static let xAxisLabel = "Macro"
        static let yAxisLabel = "Amount"
        static let proteinColor: Color = .green
        static let carbsColor: Color = .orange
        static let fatsColor: Color = .purple
    }
}
