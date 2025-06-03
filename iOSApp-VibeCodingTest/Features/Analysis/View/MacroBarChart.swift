//
//  MacroBarChart.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Charts
import SwiftUI

struct MacroBarChart: View {
    let data: [Date: (protein: Int, carbs: Int, fats: Int)]
    let range: AnalysisViewModel.TimeRange

    var chartEntries: [MacroStackEntry] {
        data.flatMap { (date, values) in
            [
                MacroStackEntry(date: date, macro: AppConstants.Nutrients.Titles.protein, value: values.protein, color: AppConstants.Nutrients.Colors.protein),
                MacroStackEntry(date: date, macro: AppConstants.Nutrients.Titles.carbs, value: values.carbs, color: AppConstants.Nutrients.Colors.carbs),
                MacroStackEntry(date: date, macro: AppConstants.Nutrients.Titles.fats, value: values.fats, color: AppConstants.Nutrients.Colors.fats)
            ]
        }
    }

    var body: some View {
        let sorted = chartEntries.sorted { $0.date < $1.date }
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(sorted) { entry in
                    BarMark(
                        x: .value("Date", dateLabel(for: entry.date)),
                        y: .value("Grams", entry.value)
                    )
                    .foregroundStyle(entry.color)
                    .position(by: .value("Macro", entry.macro))
                    .annotation(position: .top, alignment: .center) {
                        if entry.value > 0 {
                            Text("\(entry.macro.first!): \(entry.value)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(minWidth: CGFloat(sorted.count) * 40, maxHeight: .infinity)
                .id(Constants.chartEndId)
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .onChange(of: range) {
                withAnimation {
                    proxy.scrollTo(Constants.chartEndId, anchor: .trailing)
                }
            }
        }
    }

    private func dateLabel(for date: Date) -> String {
        switch range {
        case .oneDay:
            return "Today"
        case .oneWeek:
            return DateFormatter.shortWeekday.string(from: date)
        case .twoWeeks, .threeWeeks, .oneMonth:
            return DateFormatter.dayOfMonth.string(from: date)
        }
    }
    
    private enum Constants {
        static let chartEndId = "chartEnd"
    }
}
