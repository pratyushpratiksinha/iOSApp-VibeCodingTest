//
//  MacroBarChart.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Charts
import SwiftUI

struct MacroBarChart: View {
    let data: (protein: Int, carbs: Int, fats: Int)

    var body: some View {
        let entries = [
            MacroEntry(
                name: AppConstants.Nutrients.Titles.protein,
                value: data.protein,
                color: AppConstants.Nutrients.Colors.protein
            ),
            MacroEntry(
                name: AppConstants.Nutrients.Titles.carbs,
                value: data.carbs,
                color: AppConstants.Nutrients.Colors.carbs
            ),
            MacroEntry(
                name: AppConstants.Nutrients.Titles.fats,
                value: data.fats,
                color: AppConstants.Nutrients.Colors.fats
            )
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
        static let xAxisLabel = "Macro"
        static let yAxisLabel = "Amount (g)"
    }
}
