//
//  DailyTrendChart.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI
import Charts

struct DailyTrendChart: View {
    let data: [Date: Int]

    var body: some View {
        let sortedData = data.sorted { $0.key < $1.key }

        Chart(sortedData, id: \.0) { date, value in
            BarMark(
                x: .value(Constants.xAxisLabel, date, unit: .day),
                y: .value(Constants.yAxisLabel, value)
            )
            .foregroundStyle(Constants.barColor)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.weekday(.short))
            }
        }
    }

    private enum Constants {
        static let xAxisLabel = "Date"
        static let yAxisLabel = "Calories"
        static let barColor: Color = .blue
    }
}
