//
//  CameraService.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import UIKit

actor CameraService {
    private let apiKey = AppConfig.apiKey
    private let baseURL = AppConfig.baseURL
    private var maxTokensLeft: Int

    init() {
        maxTokensLeft = UserDefaults.standard.integer(forKey: AppStorageKeys.maxTokensKey)
        if maxTokensLeft == 0 {
            maxTokensLeft = Constants.defaultMaxTokens
            UserDefaults.standard.set(Constants.defaultMaxTokens, forKey: AppStorageKeys.maxTokensKey)
        }
    }

    private func updateMaxTokens(_ newValue: Int) {
        maxTokensLeft = newValue
        UserDefaults.standard.set(newValue, forKey: AppStorageKeys.maxTokensKey)
    }

    func analyzeFoodImage(_ image: UIImage) async throws -> VisionAPIResponse {
        maxTokensLeft = UserDefaults.standard.integer(forKey: AppStorageKeys.maxTokensKey)

        let resized = image.scaledDown(toMaxDimension: 1024)
        guard let imageData = resized.jpegData(compressionQuality: 0.6) else {
            throw CameraServiceError.invalidImage
        }

        let base64Image = imageData.base64EncodedString()

        let requestBody: [String: Any] = [
            "model": Constants.model,
            "max_tokens": maxTokensLeft,
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": Constants.analysisPromptPrefix + "\(maxTokensLeft) minus the compeltion tokens minus \(Constants.tokenAdjustment) used in this response (based on response length). Exclude any items not visible in the image.",
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)",
                            ],
                        ],
                    ],
                ],
            ],
        ]

        guard let url = URL(string: baseURL) else {
            throw CameraServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(Constants.authPrefix)\(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue(Constants.contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CameraServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw CameraServiceError.apiError(statusCode: httpResponse.statusCode, data: data)
        }

        do {
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(OpenRouterResponse.self, from: data)

            guard let content = apiResponse.choices.first?.message.content else {
                throw CameraServiceError.decodingError
            }

            if content.contains("I'm unable to analyze food from this image") || content.contains("The image does not contain any visible food items") {
                throw CameraServiceError.noFoodDetected
            }

            guard let start = content.range(of: "{"),
                  let end = content.range(of: "}", options: .backwards)
            else {
                throw CameraServiceError.decodingError
            }

            let jsonString = String(content[start.lowerBound ... end.upperBound])
            guard let jsonData = jsonString.data(using: .utf8) else {
                throw CameraServiceError.decodingError
            }

            guard let visionResponse = try? decoder.decode(VisionAPIResponse.self, from: jsonData)
            else {
                if let errorMessage = String(data: data, encoding: .utf8),
                   errorMessage.contains("I'm unable to analyze food from this image") {
                    throw CameraServiceError.noFoodDetected
                }
                throw CameraServiceError.decodingError
            }

            if visionResponse.foodItems.isEmpty {
                updateMaxTokens(visionResponse.maxTokensLeft)
                throw CameraServiceError.noFoodDetected
            }

            updateMaxTokens(visionResponse.maxTokensLeft)
            return visionResponse
        } catch {
            if let cameraError = error as? CameraServiceError {
                throw cameraError
            }
            throw CameraServiceError.decodingError
        }
    }

    private enum Constants {
        static let baseURL = "https://openrouter.ai/api/v1/chat/completions"
        static let model = "openai/gpt-4o"
        static let contentType = "application/json"
        static let authPrefix = "Bearer "
        static let defaultMaxTokens = 3990
        static let tokenAdjustment = 20

        static let analysisPromptPrefix = """
        Analyze the food in this image and provide a JSON response matching the following Swift structs:

        ```swift
        struct FoodItemResponse: Codable, Identifiable, Equatable {
            let id: UUID
            var name: String
            var calories: Int
            var proteins: Double
            var carbs: Double
            var fats: Double
            var portion: String?
        }

        struct VisionAPIResponse: Codable, Equatable {
            var foodItems: [FoodItemResponse]
            let totalCalories: Int
            let confidence: Double
            let timestamp: Date
            let maxTokensLeft: Int
        }

        Return a single FoodItemResponse in the foodItems array, representing the entire meal. Generate a UUID for the id, estimate nutritional values (calories, proteins, carbs, fats) for the combined meal, and include a portion description summarizing the meal. Provide the total calories (matching the single item's calories), a confidence score (0.0 to 1.0), the current timestamp as a Unix timestamp in milliseconds (e.g., 1743128460000), and an estimated maxTokensLeft calculated as
        """
    }
}
