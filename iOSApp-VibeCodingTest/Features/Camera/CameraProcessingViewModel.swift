//
//  CameraProcessingViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Foundation
import SwiftUI

@Observable
final class CameraProcessingViewModel {
    var foodName: String = ""
    var calories: String = ""
    var protein: String = ""
    var carbs: String = ""
    var fats: String = ""

    let result: VisionAPIResponse

    init(result: VisionAPIResponse) {
        self.result = result
        loadDefaults()
    }

    func loadDefaults() {
        if let food = result.foodItems.first {
            foodName = food.name
            calories = String(food.calories)
            protein = String(Int(food.proteins))
            carbs = String(Int(food.carbs))
            fats = String(Int(food.fats))
        }
    }

    func buildFoodItem() -> FoodItemResponse {
        FoodItemResponse(
            name: foodName,
            calories: Int(calories) ?? 0,
            proteins: Double(protein) ?? 0,
            carbs: Double(carbs) ?? 0,
            fats: Double(fats) ?? 0
        )
    }
}
