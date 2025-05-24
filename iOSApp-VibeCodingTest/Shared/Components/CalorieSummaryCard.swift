//
//  CalorieSummaryCard.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct CalorieSummaryCard: View {
    @Binding var caloriesConsumed: Int
    @Binding var calorieGoal: Int

    private var caloriesLeft: Int { calorieGoal - caloriesConsumed }
    private var caloriesOver: Int? { caloriesLeft < 0 ? abs(caloriesLeft) : nil }

    var body: some View {
        HStack(spacing: Constants.hStackSpacing) {
            VStack(alignment: .leading) {
                Text(caloriesOver != nil ? "\(caloriesOver!)" : "\(caloriesLeft)")
                    .font(.system(size: Constants.valueFontSize, weight: .bold))
                Text(caloriesOver != nil ? Constants.caloriesOver : Constants.caloriesLeft)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            CircularProgressBar(
                progress: calorieGoal == 0 ? 0 : Double(caloriesConsumed) / Double(calorieGoal),
                image: Constants.icon,
                color: Constants.progressColor,
                lineWidth: Constants.progressLineWidth
            )
            .frame(width: Constants.progressSize, height: Constants.progressSize)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: Constants.shadowYOffset)
    }

    private enum Constants {
        static let caloriesLeft = "Calories left"
        static let caloriesOver = "Calories over"
        static let icon = "flame"
        static let progressColor = Color.accentColor
        static let progressLineWidth: CGFloat = 8
        static let progressSize: CGFloat = 64
        static let valueFontSize: CGFloat = 36
        static let cornerRadius: CGFloat = 20
        static let hStackSpacing: CGFloat = 16
        static let shadowColor = Color.black.opacity(0.1)
        static let shadowRadius: CGFloat = 8
        static let shadowYOffset: CGFloat = 2
    }
}
