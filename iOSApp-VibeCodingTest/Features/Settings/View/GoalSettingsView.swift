//
//  GoalSettingsView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftData
import SwiftUI

struct GoalSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var userSettings: [UserSettings]
    @State private var viewModel: GoalSettingsViewModel? = nil
    @State private var showValidationError = false
    @State private var validationMessage = ""
    @FocusState private var focusedField: NutrientField?
    
    var body: some View {
        NavigationStack {
            Group {
                if let unwrapped = viewModel {
                    @Bindable var model = unwrapped
                    
                    Form {
                        Section {
                            MacroInputField(
                                title: AppConstants.Nutrients.Titles.calories,
                                value: $model.calorieGoal,
                                icon: AppConstants.Nutrients.Icons.caloriesDefault,
                                color: AppConstants.Nutrients.Colors.calories,
                                unit: AppConstants.Nutrients.Units.calories,
                                isFocused: focusedField == .calories,
                                field: .calories,
                                focusedField: $focusedField
                            )
                            
                            MacroInputField(
                                title: AppConstants.Nutrients.Titles.protein,
                                value: $model.proteinGoal,
                                icon: AppConstants.Nutrients.Icons.proteinDefault,
                                color: AppConstants.Nutrients.Colors.protein,
                                unit: AppConstants.Nutrients.Units.protein,
                                isFocused: focusedField == .protein,
                                field: .protein,
                                focusedField: $focusedField
                            )
                            
                            MacroInputField(
                                title: AppConstants.Nutrients.Titles.carbs,
                                value: $model.carbsGoal,
                                icon: AppConstants.Nutrients.Icons.carbsDefault,
                                color: AppConstants.Nutrients.Colors.carbs,
                                unit: AppConstants.Nutrients.Units.carbs,
                                isFocused: focusedField == .carbs,
                                field: .carbs,
                                focusedField: $focusedField
                            )
                            
                            MacroInputField(
                                title: AppConstants.Nutrients.Titles.fats,
                                value: $model.fatsGoal,
                                icon: AppConstants.Nutrients.Icons.fatsDefault,
                                color: AppConstants.Nutrients.Colors.fats,
                                unit: AppConstants.Nutrients.Units.fats,
                                isFocused: focusedField == .fats,
                                field: .fats,
                                focusedField: $focusedField
                            )
                        } header: {
                            Text(Constants.inputSectionHeader)
                        } footer: {
                            if !model.validationErrors.isEmpty {
                                Text(model.validationErrors.joined(separator: "\n"))
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                        
                        Section {
                            Button {
                                Task { @MainActor in
                                    await saveGoals(model)
                                }
                            } label: {
                                HStack {
                                    if model.isLoading {
                                        ProgressView()
                                            .tint(.white)
                                            .padding(.trailing, 8)
                                    }
                                    Text(Constants.saveButton)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: AppConstants.UI.buttonHeight)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(!model.isValid || model.isLoading)
                            .padding(.horizontal, AppConstants.UI.horizontalPadding)
                            .padding(.top, AppConstants.UI.buttonTopPadding)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .navigationTitle(Constants.title)
                    .alert(Constants.errorTitle, isPresented: $showValidationError) {
                        Button(Constants.errorButtonTitle, role: .cancel) {}
                    } message: {
                        Text(validationMessage)
                    }
                    .overlay {
                        if model.isLoading {
                            Color.black.opacity(0.2)
                                .ignoresSafeArea()
                                .overlay {
                                    ProgressView()
                                        .scaleEffect(1.5)
                                        .tint(.white)
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
    
    @MainActor
    private func saveGoals(_ model: GoalSettingsViewModel) async {
        do {
            try await model.saveGoals()
            dismiss()
        } catch {
            validationMessage = error.localizedDescription
            showValidationError = true
        }
    }
    
    private enum Constants {
        static let title = "Nutrition Goals"
        static let inputSectionHeader = "Daily Goals"
        static let saveButton = "Save Goals"
        static let errorTitle = "Invalid Input"
        static let errorButtonTitle = "OK"
    }
}

#Preview {
    GoalSettingsView()
}
