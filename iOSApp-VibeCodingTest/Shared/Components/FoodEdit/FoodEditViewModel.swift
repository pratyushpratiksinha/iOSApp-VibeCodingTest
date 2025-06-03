//
//  FoodEditViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 03/06/25.
//

import SwiftUI
import SwiftData

@Observable
final class FoodEditViewModel {
    private let food: FoodItem
    private let onSave: (() -> Void)?
    
    var name: String
    var caloriesString: String
    var proteinString: String
    var carbsString: String
    var fatsString: String
    
    var isLoading = false
    var validationErrors: [String] = []
    var showValidationAlert = false
    
    var isValid: Bool {
        validationErrors.isEmpty
    }
    
    var isEditing: Bool {
        !food.name.isEmpty
    }
    
    init(food: FoodItem, onSave: (() -> Void)?) {
        self.food = food
        self.onSave = onSave
        
        self.name = food.name
        self.caloriesString = "\(food.calories)"
        self.proteinString = "\(food.protein)"
        self.carbsString = "\(food.carbs)"
        self.fatsString = "\(food.fats)"
    }
    
    func validate() {
        validationErrors.removeAll()
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            validationErrors.append(Constants.nameRequired)
        }
    }
    
    @MainActor
    func saveFood() async throws {
        validate()
        guard isValid else {
            showValidationAlert = true
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        food.name = name
        food.calories = Int(caloriesString) ?? 0
        food.protein = Int(proteinString) ?? 0
        food.carbs = Int(carbsString) ?? 0
        food.fats = Int(fatsString) ?? 0
        onSave?()
    }
    
    private enum Constants {
        static let nameRequired = "Name is required"
    }
}
