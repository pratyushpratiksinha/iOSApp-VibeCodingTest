//
//  CalorieTrendChart.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Charts
import SwiftUI

struct CalorieTrendChart: View {
    let data: [Date: Int]
    let range: AnalysisViewModel.TimeRange

    var body: some View {
        let sortedData = data.sorted { $0.key < $1.key }

        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                Chart(sortedData, id: \.0) { date, value in
                    BarMark(
                        x: .value(Constants.xAxisLabel, dateLabel(for: date)),
                        y: .value(Constants.yAxisLabel, value)
                    )
                    .foregroundStyle(AppConstants.Nutrients.Colors.calories)
                    .annotation(position: .top, alignment: .center) {
                        if value > 0 {
                            Text("\(value)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(minWidth: CGFloat(sortedData.count) * 40, maxHeight: 200)
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
        static let xAxisLabel = "Date"
        static let yAxisLabel = "Calories"
        static let chartEndId = "calorieChartEnd"
    }
}
