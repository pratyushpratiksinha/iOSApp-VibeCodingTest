//
//  FoodEditView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct FoodEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState private var isInputFocused: Bool

    @Bindable var food: FoodItem
    
    let onSave: (() -> Void)?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(Constants.nameSection)) {
                    TextField(Constants.namePlaceholder, text: $food.name)
                        .focused($isInputFocused)
                }
                
                Section(header: Text(Constants.nutritionSection)) {
                    Stepper("\(Constants.calories): \(food.calories)", value: $food.calories, in: 0...5000)
                    Stepper("\(Constants.protein): \(food.protein)", value: $food.protein, in: 0...500)
                    Stepper("\(Constants.carbs): \(food.carbs)", value: $food.carbs, in: 0...500)
                    Stepper("\(Constants.fats): \(food.fats)", value: $food.fats, in: 0...200)
                }
            }
            .navigationTitle(Constants.navTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(Constants.saveButton) {
                        try? modelContext.save()
                        dismiss()
                        onSave?()
                    }
                    .disabled(!isValid)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(Constants.cancelButton) {
                        dismiss()
                    }
                }
            }
            .onTapGesture {
                isInputFocused = false
            }
        }
    }

    private var isValid: Bool {
        !food.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        food.calories >= 0 && food.protein >= 0 && food.carbs >= 0 && food.fats >= 0
    }

    private enum Constants {
        static let navTitle = "Edit Ingredient"
        static let nameSection = "Name"
        static let namePlaceholder = "Food name"
        static let nutritionSection = "Nutrition"
        static let calories = "Calories"
        static let protein = "Protein"
        static let carbs = "Carbs"
        static let fats = "Fats"
        static let saveButton = "Save"
        static let cancelButton = "Cancel"
    }
}
