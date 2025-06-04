//
//  FoodEditView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI
import SwiftData

struct FoodEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: FoodEditViewModel
    @FocusState private var focusedField: NutrientField?
    
    init(food: FoodItem, onSave: (() -> Void)?) {
        _viewModel = State(initialValue: FoodEditViewModel(
            food: food,
            onSave: onSave
        ))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                nameSection
                nutritionSection
            }
            .navigationTitle(viewModel.isEditing ? Constants.editTitle : Constants.addTitle)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Constants.cancelButton) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(Constants.saveButton) {
                        Task { @MainActor in
                            do {
                                try await viewModel.saveFood()
                                dismiss()
                            } catch {
                                viewModel.showValidationAlert = true
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(Constants.validationAlertTitle, isPresented: $viewModel.showValidationAlert) {
                Button(Constants.okButton, role: .cancel) { }
            } message: {
                Text(viewModel.validationErrors.joined(separator: "\n"))
            }
            .overlay { loadingOverlay }
            .interactiveDismissDisabled(viewModel.isLoading)
            .scrollDismissesKeyboard(.interactively)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
    
    private var nameSection: some View {
        Section {
            TextField(Constants.namePlaceholder, text: $viewModel.name)
                .focused($focusedField, equals: .name)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .calories
                }
        } header: {
            Text(Constants.nameSection)
        } footer: {
            if viewModel.name.isEmpty {
                Text(Constants.nameRequired)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var nutritionSection: some View {
        Section {
            MacroInputField(
                title: AppConstants.Nutrients.Titles.calories,
                value: $viewModel.caloriesString,
                icon: AppConstants.Nutrients.Icons.caloriesDefault,
                color: AppConstants.Nutrients.Colors.calories,
                unit: AppConstants.Nutrients.Units.calories,
                isFocused: focusedField == .calories,
                field: .calories,
                focusedField: $focusedField
            )
            
            MacroInputField(
                title: AppConstants.Nutrients.Titles.protein,
                value: $viewModel.proteinString,
                icon: AppConstants.Nutrients.Icons.proteinDefault,
                color: AppConstants.Nutrients.Colors.protein,
                unit: AppConstants.Nutrients.Units.protein,
                isFocused: focusedField == .protein,
                field: .protein,
                focusedField: $focusedField
            )
            
            MacroInputField(
                title: AppConstants.Nutrients.Titles.carbs,
                value: $viewModel.carbsString,
                icon: AppConstants.Nutrients.Icons.carbsDefault,
                color: AppConstants.Nutrients.Colors.carbs,
                unit: AppConstants.Nutrients.Units.carbs,
                isFocused: focusedField == .carbs,
                field: .carbs,
                focusedField: $focusedField
            )
            
            MacroInputField(
                title: AppConstants.Nutrients.Titles.fats,
                value: $viewModel.fatsString,
                icon: AppConstants.Nutrients.Icons.fatsDefault,
                color: AppConstants.Nutrients.Colors.fats,
                unit: AppConstants.Nutrients.Units.fats,
                isFocused: focusedField == .fats,
                field: .fats,
                focusedField: $focusedField
            )
        } header: {
            Text(Constants.nutritionSection)
        } footer: {
            if !viewModel.validationErrors.isEmpty {
                Text(viewModel.validationErrors.joined(separator: "\n"))
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
        
    private var loadingOverlay: some View {
        Group {
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
            }
        }
    }
    
    private enum Constants {
        static let addTitle = "Add Food"
        static let editTitle = "Edit Food"
        static let nameSection = "Name"
        static let namePlaceholder = "Food name"
        static let nameRequired = "Name is required"
        static let nutritionSection = "Nutrition"
        static let saveButton = "Save"
        static let cancelButton = "Cancel"
        static let doneButtonTitle = "Done"
        static let okButton = "OK"
        static let validationAlertTitle = "Invalid Input"
    }
}
