//
//  CameraView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var capturedImage: UIImage?
    @State private var viewModel: CameraViewModel

    init() {
        _viewModel = State(initialValue: CameraViewModel())
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle:
                CameraCaptureView { image in
                    capturedImage = image
                    Task {
                        await viewModel.analyzeImage(image)
                    }
                }

            case .analyzing:
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    ProgressView(Constants.analyzingText)
                        .progressViewStyle(.circular)
                        .padding()
                }

            case .result:
                if let image = capturedImage, let result = viewModel.analysisResult {
                    CameraProcessingView(
                        image: image,
                        result: result,
                        onSave: { updated in
                            viewModel.saveFoodItem(from: updated, image: image, modelContext: modelContext)
                            reset()
                            dismiss()
                        },
                        onCancel: reset
                    )
                }

            case let .error(message):
                VStack {
                    Text(message)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(Constants.retryButton) { reset() }
                        .buttonStyle(.bordered)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.state)
    }

    private func reset() {
        capturedImage = nil
        viewModel.resetState()
    }

    private enum Constants {
        static let analyzingText = "Analyzing..."
        static let retryButton = "Retry"
    }
}
