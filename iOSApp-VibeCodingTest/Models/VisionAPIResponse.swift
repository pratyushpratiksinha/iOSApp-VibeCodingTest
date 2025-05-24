//
//  VisionAPIResponse.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import UIKit

/// Represents a single food item returned by the Vision API.
/// Note: Macros are typically returned as Doubles by APIs, and this struct reflects that.
struct FoodItemResponse: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var calories: Int
    var proteins: Double
    var carbs: Double
    var fats: Double
    var portion: String?

    // Custom initializer to provide default ID
    init(id: UUID = UUID(), name: String, calories: Int, proteins: Double, carbs: Double, fats: Double, portion: String? = nil) {
        self.id = id
        self.name = name
        self.calories = calories
        self.proteins = proteins
        self.carbs = carbs
        self.fats = fats
        self.portion = portion
    }
}

/// Represents the overall response structure from the Vision API.
struct VisionAPIResponse: Codable, Equatable {
    var foodItems: [FoodItemResponse]
    let totalCalories: Int
    let confidence: Double
    let timestamp: Date

     init(foodItems: [FoodItemResponse], totalCalories: Int, confidence: Double, timestamp: Date = Date()) {
         self.foodItems = foodItems
         self.totalCalories = totalCalories
         self.confidence = confidence
         self.timestamp = timestamp
     }

     static func == (lhs: VisionAPIResponse, rhs: VisionAPIResponse) -> Bool {
         lhs.foodItems == rhs.foodItems &&
         lhs.totalCalories == rhs.totalCalories &&
         lhs.confidence == rhs.confidence &&
         lhs.timestamp.timeIntervalSince1970 == rhs.timestamp.timeIntervalSince1970 // Compare timestamps for Equatable
     }
}
