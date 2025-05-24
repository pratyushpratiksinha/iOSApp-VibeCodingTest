//
//  CameraProcessingView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct CameraProcessingView: View {
    let image: UIImage
    @State private var model: CameraProcessingViewModel
    let onSave: (FoodItemResponse) -> Void
    let onCancel: () -> Void

    @FocusState private var isInputFocused: Bool

    init(image: UIImage, result: VisionAPIResponse, onSave: @escaping (FoodItemResponse) -> Void, onCancel: @escaping () -> Void) {
        self.image = image
        self.onSave = onSave
        self.onCancel = onCancel
        _model = State(initialValue: CameraProcessingViewModel(result: result))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.verticalSpacing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Constants.cornerRadius)
                    .padding(.top)

                VStack(spacing: Constants.inputSectionSpacing) {
                    TextField(Constants.foodNamePlaceholder, text: $model.foodName)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .focused($isInputFocused)

                    HStack(spacing: Constants.macroFieldSpacing) {
                        macroField(title: Constants.caloriesLabel, value: $model.calories)
                        macroField(title: Constants.proteinLabel, value: $model.protein)
                        macroField(title: Constants.carbsLabel, value: $model.carbs)
                        macroField(title: Constants.fatsLabel, value: $model.fats)
                    }
                }

                HStack(spacing: Constants.buttonSpacing) {
                    Button(Constants.fixButtonTitle) {
                        model.loadDefaults()
                    }
                    .buttonStyle(.bordered)

                    Button(Constants.doneButtonTitle) {
                        onSave(model.buildFoodItem())
                    }
                    .buttonStyle(.borderedProminent)
                }

                Button(Constants.retakeButtonTitle) {
                    onCancel()
                }
                .foregroundColor(.secondary)
                .padding(.top)
            }
            .padding()
        }
        .onTapGesture {
            isInputFocused = false
        }
    }

    private func macroField(title: String, value: Binding<String>) -> some View {
        VStack(spacing: Constants.macroFieldLabelSpacing) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            TextField(Constants.defaultMacroPlaceholder, text: value)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: Constants.macroFieldWidth)
                .textFieldStyle(.roundedBorder)
                .focused($isInputFocused)
        }
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let verticalSpacing: CGFloat = 20
        static let inputSectionSpacing: CGFloat = 12
        static let macroFieldSpacing: CGFloat = 16
        static let macroFieldLabelSpacing: CGFloat = 4
        static let macroFieldWidth: CGFloat = 60
        static let buttonSpacing: CGFloat = 16

        static let foodNamePlaceholder = "Food name"
        static let defaultMacroPlaceholder = "0"

        static let caloriesLabel = "Calories"
        static let proteinLabel = "Protein"
        static let carbsLabel = "Carbs"
        static let fatsLabel = "Fats"

        static let fixButtonTitle = "Fix Results"
        static let doneButtonTitle = "Done"
        static let retakeButtonTitle = "Retake"
    }
}
