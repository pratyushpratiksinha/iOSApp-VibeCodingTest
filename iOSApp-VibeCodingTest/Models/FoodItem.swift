//
//  FoodItem.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import SwiftData

@Model
final class FoodItem {
    var id: UUID
    var name: String
    var calories: Int
    var protein: Int
    var carbs: Int
    var fats: Int
    var date: Date
    var imageData: Data?
    var notes: String?
    
    init(
        id: UUID = UUID(),
        name: String,
        calories: Int,
        protein: Int,
        carbs: Int,
        fats: Int,
        date: Date = Date(),
        imageData: Data? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
        self.date = date
        self.imageData = imageData
        self.notes = notes
    }
}
