//
//  CameraViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI
import SwiftData
import Observation

@Observable
@MainActor
final class CameraViewModel {
    enum State: Equatable {
        case idle
        case analyzing
        case result
        case error(String)
    }

    // MARK: - Properties
    private let cameraService: CameraService
    var state: State = .idle
    var capturedImage: UIImage?
    var analysisResult: VisionAPIResponse?

    // MARK: - Initialization
    init() {
        let apiKey = "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"
        self.cameraService = CameraService(apiKey: apiKey)
    }

    // MARK: - Public Methods
    func analyzeImage(_ image: UIImage) async {
        state = .analyzing
        capturedImage = image

        do {
            let result = try await cameraService.analyzeFoodImage(image)
            analysisResult = result
            state = .result
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func saveFoodItem(from food: FoodItemResponse, image: UIImage?, modelContext: ModelContext) {
        let foodItem = FoodItem(from: food, image: image)
        modelContext.insert(foodItem)
    }

    func resetState() {
        state = .idle
        capturedImage = nil
        analysisResult = nil
    }
}
