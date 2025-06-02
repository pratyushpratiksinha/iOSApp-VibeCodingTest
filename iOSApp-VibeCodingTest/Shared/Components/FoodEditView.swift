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
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button(Constants.doneButtonTitle) {
                                    isInputFocused = false
                                }
                            }
                        }
                }

                Section(header: Text(Constants.nutritionSection)) {
                    Stepper(
                        "\(AppConstants.Nutrients.Titles.calories): \(food.calories) \(AppConstants.Nutrients.Units.calories)",
                        value: $food.calories,
                        in: 0...AppConstants.Nutrients.MaxValue.Calories
                    )
                    Stepper(
                        "\(AppConstants.Nutrients.Titles.protein): \(food.protein)\(AppConstants.Nutrients.Units.protein)",
                        value: $food.protein,
                        in: 0...AppConstants.Nutrients.MaxValue.Protein
                    )
                    Stepper(
                        "\(AppConstants.Nutrients.Titles.carbs): \(food.carbs)\(AppConstants.Nutrients.Units.carbs)",
                        value: $food.carbs,
                        in: 0...AppConstants.Nutrients.MaxValue.Carbs
                    )
                    Stepper(
                        "\(AppConstants.Nutrients.Titles.fats): \(food.fats)\(AppConstants.Nutrients.Units.fats)",
                        value: $food.fats,
                        in: 0...AppConstants.Nutrients.MaxValue.Fats
                    )
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
            food.calories >= AppConstants.Nutrients.MinValue.Calories &&
            food.protein >= AppConstants.Nutrients.MinValue.Macro &&
            food.carbs >= AppConstants.Nutrients.MinValue.Macro &&
            food.fats >= AppConstants.Nutrients.MinValue.Macro
    }

    private enum Constants {
        static let navTitle = "Edit Ingredient"
        static let nameSection = "Name"
        static let namePlaceholder = "Food name"
        static let nutritionSection = "Nutrition"
        static let saveButton = "Save"
        static let cancelButton = "Cancel"
        static let doneButtonTitle = "Done"
    }
}
