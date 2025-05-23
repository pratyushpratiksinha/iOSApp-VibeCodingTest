//
//  GoalSettingsView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI
import SwiftData

struct GoalSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var userSettings: [UserSettings]
    @State private var viewModel: GoalSettingsViewModel? = nil

    var body: some View {
        NavigationStack {
            Group {
                if let unwrapped = viewModel {
                    @Bindable var model = unwrapped

                    Form {
                        Section(header: Text(Constants.calorieSection)) {
                            TextField(Constants.calorieGoal, text: $model.calorieGoal)
                                .keyboardType(.numberPad)
                        }

                        Section(header: Text(Constants.proteinSection)) {
                            TextField(Constants.proteinGoal, text: $model.proteinGoal)
                                .keyboardType(.numberPad)
                        }

                        Section(header: Text(Constants.carbsSection)) {
                            TextField(Constants.carbsGoal, text: $model.carbsGoal)
                                .keyboardType(.numberPad)
                        }

                        Section(header: Text(Constants.fatsSection)) {
                            TextField(Constants.fatsGoal, text: $model.fatsGoal)
                                .keyboardType(.numberPad)
                        }
                    }
                    .navigationTitle(Constants.title)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button(Constants.saveButton) {
                                try? model.saveGoals()
                                dismiss()
                            }
                            .disabled(!model.isValid)
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button(Constants.cancelButton) {
                                dismiss()
                            }
                        }
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            viewModel = GoalSettingsViewModel(
                                modelContext: modelContext,
                                initialSettings: userSettings
                            )
                        }
                }
            }
        }
    }

    private enum Constants {
        static let title = "Nutrition Goals"
        static let calorieSection = "Calorie Goal"
        static let proteinSection = "Protein Goals"
        static let carbsSection = "Carbs Goals"
        static let fatsSection = "Fats Goals"
        static let calorieGoal = "Calories (kcal)"
        static let proteinGoal = "Protein (g)"
        static let carbsGoal = "Carbs (g)"
        static let fatsGoal = "Fats (g)"
        static let saveButton = "Save"
        static let cancelButton = "Cancel"
    }
}
