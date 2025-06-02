//
//  MacrosSummaryView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct MacrosSummaryView: View {
    @Binding var proteinConsumed: Int
    @Binding var proteinGoal: Int
    @Binding var carbsConsumed: Int
    @Binding var carbsGoal: Int
    @Binding var fatsConsumed: Int
    @Binding var fatsGoal: Int

    var body: some View {
        HStack(spacing: Constants.hStackSpacing) {
            macroCard(
                title: AppConstants.Nutrients.Titles.protein,
                consumed: proteinConsumed,
                goal: proteinGoal,
                icon: AppConstants.Nutrients.Icons.protein,
                color: AppConstants.Nutrients.Colors.protein
            )
            macroCard(
                title: AppConstants.Nutrients.Titles.carbs,
                consumed: carbsConsumed,
                goal: carbsGoal,
                icon: AppConstants.Nutrients.Icons.carbs,
                color: AppConstants.Nutrients.Colors.carbs
            )
            macroCard(
                title: AppConstants.Nutrients.Titles.fats,
                consumed: fatsConsumed,
                goal: fatsGoal,
                icon: AppConstants.Nutrients.Icons.fats,
                color: AppConstants.Nutrients.Colors.fats
            )
        }
    }

    private func macroCard(title: String, consumed: Int, goal: Int, icon: String, color: Color) -> some View {
        let left = goal - consumed
        let over = left < 0 ? abs(left) : nil
        let unit = title == AppConstants.Nutrients.Titles.calories ? 
            AppConstants.Nutrients.Units.calories : 
            AppConstants.Nutrients.Units.protein

        return VStack(spacing: Constants.vStackSpacing) {
            CircularProgressBar(
                progress: goal == 0 ? 0 : Double(consumed) / Double(goal),
                image: icon,
                color: color,
                lineWidth: Constants.progressLineWidth
            )
            .frame(width: Constants.progressSize, height: Constants.progressSize)

            Text(over != nil ? "\(over!)\(unit)" : "\(left)\(unit)")
                .font(.headline)

            Text(over != nil ? "\(title) \(AppConstants.Nutrients.Titles.overSuffix)" : "\(title) \(AppConstants.Nutrients.Titles.leftSuffix)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.cardPadding)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: Constants.shadowYOffset)
    }

    private enum Constants {
        static let progressLineWidth: CGFloat = 4
        static let progressSize: CGFloat = 32
        static let cardPadding: CGFloat = 12
        static let cornerRadius: CGFloat = 14
        static let hStackSpacing: CGFloat = 16
        static let vStackSpacing: CGFloat = 4
        static let shadowColor = Color.black.opacity(0.1)
        static let shadowRadius: CGFloat = 8
        static let shadowYOffset: CGFloat = 2
    }
}
