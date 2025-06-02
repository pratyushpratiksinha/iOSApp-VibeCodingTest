//
//  FoodCard.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct FoodCard: View {
    let food: FoodItem
    let onTap: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            if let imageData = food.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipped()
                    .cornerRadius(6)
            } else {
                Rectangle()
                    .fill(AppConstants.Nutrients.Colors.carbs.opacity(0.2))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: AppConstants.Nutrients.Icons.carbs)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .foregroundColor(AppConstants.Nutrients.Colors.carbs)
                    )
                    .cornerRadius(6)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.subheadline.bold())
                Label(
                    "\(food.calories) \(AppConstants.Nutrients.Units.calories)",
                    systemImage: AppConstants.Nutrients.Icons.calories
                )
                    .font(.caption)
                    .foregroundColor(AppConstants.Nutrients.Colors.calories)
                HStack(spacing: 8) {
                    Label(
                        "\(food.protein)\(AppConstants.Nutrients.Units.protein)",
                        systemImage: AppConstants.Nutrients.Icons.protein
                    )
                        .foregroundColor(AppConstants.Nutrients.Colors.protein)
                    Label(
                        "\(food.carbs)\(AppConstants.Nutrients.Units.carbs)",
                        systemImage: AppConstants.Nutrients.Icons.carbs
                    )
                        .foregroundColor(AppConstants.Nutrients.Colors.carbs)
                    Label(
                        "\(food.fats)\(AppConstants.Nutrients.Units.fats)",
                        systemImage: AppConstants.Nutrients.Icons.fats
                    )
                        .foregroundColor(AppConstants.Nutrients.Colors.fats)
                }
            }
            Spacer()
            Text(food.timestamp, style: .time)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 4)
        .onTapGesture {
            onTap?()
        }
    }
}
