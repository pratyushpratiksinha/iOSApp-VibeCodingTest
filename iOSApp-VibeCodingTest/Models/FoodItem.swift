//
//  FoodItem.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import SwiftData
import UIKit

@Model
final class FoodItem {
    var id: UUID
    var name: String
    var calories: Int
    var protein: Int
    var carbs: Int
    var fats: Int
    var timestamp: Date
    var imageData: Data?
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        calories: Int,
        protein: Int,
        carbs: Int,
        fats: Int,
        timestamp: Date = Date(),
        imageData: Data? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
        self.timestamp = timestamp
        self.imageData = imageData
        self.notes = notes
    }
}

extension FoodItem {
    convenience init(from response: FoodItemResponse, image: UIImage? = nil, notes: String? = nil) {
        self.init(
            name: response.name,
            calories: response.calories,
            protein: Int(response.proteins),
            carbs: Int(response.carbs),
            fats: Int(response.fats),
            timestamp: Date(),
            imageData: image?.jpegData(compressionQuality: 0.6),
            notes: notes
        )
    }
}
