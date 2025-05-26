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
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "leaf")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .foregroundColor(.green)
                    )
                    .cornerRadius(6)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                    .font(.subheadline.bold())
                Label("\(food.calories) calories", systemImage: Constants.flameIcon)
                    .font(.caption)
                    .foregroundColor(.blue)
                HStack(spacing: 8) {
                    Label("\(food.protein)g", systemImage: Constants.proteinIcon)
                        .foregroundColor(.red)
                    Label("\(food.carbs)g", systemImage: Constants.carbsIcon)
                        .foregroundColor(.orange)
                    Label("\(food.fats)g", systemImage: Constants.fatsIcon)
                        .foregroundColor(.purple)
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

    private enum Constants {
        static let flameIcon = "flame"
        static let proteinIcon = "fork.knife"
        static let carbsIcon = "leaf"
        static let fatsIcon = "drop"
    }
}
