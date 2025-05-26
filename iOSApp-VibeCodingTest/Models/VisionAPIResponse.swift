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
    let maxTokensLeft: Int

    enum CodingKeys: String, CodingKey {
        case foodItems
        case totalCalories
        case confidence
        case timestamp
        case maxTokensLeft
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        foodItems = try container.decode([FoodItemResponse].self, forKey: .foodItems)
        totalCalories = try container.decode(Int.self, forKey: .totalCalories)
        confidence = try container.decode(Double.self, forKey: .confidence)
        let timestampMs = try container.decode(Double.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timestampMs / 1000.0)
        maxTokensLeft = try container.decode(Int.self, forKey: .maxTokensLeft)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(foodItems, forKey: .foodItems)
        try container.encode(totalCalories, forKey: .totalCalories)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(timestamp.timeIntervalSince1970 * 1000.0, forKey: .timestamp)
        try container.encode(maxTokensLeft, forKey: .maxTokensLeft)
    }

    init(foodItems: [FoodItemResponse], totalCalories: Int, confidence: Double, timestamp: Date = Date(), maxTokenLeft: Int = 0) {
        self.foodItems = foodItems
        self.totalCalories = totalCalories
        self.confidence = confidence
        self.timestamp = timestamp
        self.maxTokensLeft = maxTokenLeft
    }

    static func == (lhs: VisionAPIResponse, rhs: VisionAPIResponse) -> Bool {
        lhs.foodItems == rhs.foodItems &&
            lhs.totalCalories == rhs.totalCalories &&
            lhs.confidence == rhs.confidence &&
            lhs.timestamp.timeIntervalSince1970 == rhs.timestamp.timeIntervalSince1970 // Compare timestamps for Equatable
    }
}
