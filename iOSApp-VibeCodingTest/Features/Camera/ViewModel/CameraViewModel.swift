//
//  CameraViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Observation
import SwiftData
import SwiftUI

@Observable
@MainActor
final class CameraViewModel {
    enum State: Equatable {
        case idle
        case analyzing
        case result
        case error(String)
    }

    private let cameraService: CameraService
    var state: State = .idle
    var capturedImage: UIImage?
    var analysisResult: VisionAPIResponse?

    init() {
        cameraService = CameraService()
    }

    func analyzeImage(_ image: UIImage) async {
        state = .analyzing
        capturedImage = image

        do {
            let result = try await cameraService.analyzeFoodImage(image)
            analysisResult = result
            state = .result
        } catch let error as CameraServiceError {
            switch error {
            case .noFoodDetected:
                state = .error(error.localizedDescription)
            default:
                let rawError = error.localizedDescription
                let prefix = "API Error (402):"

                let jsonString = rawError.jsonPayloadAfterPrefix(prefix)

                if let errorDict = jsonString.toDictionary(),
                   let errorInfo = errorDict["error"] as? [String: Any],
                   let message = errorInfo["message"] as? String {
                    let tokenLeft = message.extractAffordableMaxToken()
                    if let tokenLeft {
                        UserDefaults.standard.set(tokenLeft - 4, forKey: AppStorageKeys.maxTokensKey)
                    }

                    state = .error("Failed to analyze image: \(message)")
                } else {
                    state = .error("Failed to analyze image: \(rawError)")
                }
            }
        } catch {
            state = .error("An unexpected error occurred: \(error.localizedDescription)")
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
