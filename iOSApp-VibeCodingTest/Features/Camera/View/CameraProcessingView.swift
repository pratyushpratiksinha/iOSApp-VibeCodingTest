//
//  CameraProcessingView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct CameraProcessingView: View {
    @Environment(\.dismiss) private var dismiss
    let image: UIImage
    @State private var viewModel: CameraProcessingViewModel
    let onSave: (FoodItemResponse) -> Void
    let onCancel: () -> Void
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    @FocusState private var isInputFocused: Bool

    init(image: UIImage, result: VisionAPIResponse, onSave: @escaping (FoodItemResponse) -> Void, onCancel: @escaping () -> Void) {
        self.image = image
        self.onSave = onSave
        self.onCancel = onCancel
        _viewModel = State(initialValue: CameraProcessingViewModel(result: result))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(height: 248)

                VStack(spacing: Constants.verticalSpacing) {
                    Spacer(minLength: 280)

                    VStack(spacing: Constants.innerSpacing) {
                        TextField(Constants.foodNamePlaceholder, text: $viewModel.foodName)
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                            .padding(12)
                            .cornerRadius(Constants.cornerRadius)
                            .focused($isInputFocused)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Constants.gridSpacing) {
                            nutritionField(icon: Constants.caloriesIcon, title: Constants.caloriesLabel, value: $viewModel.calories, color: .orange)
                            nutritionField(icon: Constants.carbsIcon, title: Constants.carbsLabel, value: $viewModel.carbs, color: .green)
                            nutritionField(icon: Constants.proteinIcon, title: Constants.proteinLabel, value: $viewModel.protein, color: .red)
                            nutritionField(icon: Constants.fatsIcon, title: Constants.fatsLabel, value: $viewModel.fats, color: .purple)
                        }
                        .padding(.top, 8)

                        HStack(spacing: Constants.buttonSpacing) {
                            Button(Constants.fixButtonTitle) {
                                viewModel.loadDefaults()
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .frame(maxWidth: .infinity)

                            Button(Constants.doneButtonTitle) {
                                onSave(viewModel.buildFoodItem())
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .frame(maxWidth: .infinity)
                        }

                        Button(Constants.retakeButtonTitle) {
                            onCancel()
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(.systemGray6))
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
                    )
                }
                .padding(.bottom, 0)
                .ignoresSafeArea(edges: .bottom)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(Constants.doneButtonTitle) {
                            isInputFocused = false
                        }
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button(Constants.cancelButtonTitle) {
                            dismiss()
                        }
                        .foregroundColor(Color.white)
                    }
                }
                .onTapGesture {
                    isInputFocused = false
                }
            }
        }
        .alert(Constants.errorTitle, isPresented: $showErrorAlert) {
            Button(Constants.okTitle) {
                onCancel()
            }
        } message: {
            Text(errorMessage)
        }
    }

    private func nutritionField(icon: String, title: String, value: Binding<String>, color: Color) -> some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            TextField("0", text: value)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .focused($isInputFocused)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let verticalSpacing: CGFloat = 20
        static let innerSpacing: CGFloat = 12
        static let gridSpacing: CGFloat = 16
        static let buttonSpacing: CGFloat = 16

        static let foodNamePlaceholder = "Food name"

        static let caloriesLabel = "Calories"
        static let proteinLabel = "Protein"
        static let carbsLabel = "Carbs"
        static let fatsLabel = "Fats"

        static let caloriesIcon = "flame.fill"
        static let carbsIcon = "leaf.fill"
        static let proteinIcon = "fork.knife"
        static let fatsIcon = "drop.fill"

        static let fixButtonTitle = "Fix Results                           "
        static let doneButtonTitle = "Done                               "
        static let retakeButtonTitle = "Retake"
        static let cancelButtonTitle = "Cancel"
        static let errorTitle = "Analysis Error"
        static let okTitle = "OK"
    }
}

extension CameraProcessingView {
    func handleError(_ error: Error) {
        if let cameraError = error as? CameraServiceError {
            errorMessage = cameraError.localizedDescription
            showErrorAlert = true
        } else {
            errorMessage = "An unexpected error occurred. Please try again."
            showErrorAlert = true
        }
    }
}
