//
//  CameraService.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import UIKit

actor CameraService {
    private let apiKey: String
    private let baseURL = "https://api.openai.com/v1/chat/completions"

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func analyzeFoodImage(_ image: UIImage) async throws -> VisionAPIResponse {
        
        let resized = image.scaledDown(toMaxDimension: 1024)
        guard let imageData = resized.jpegData(compressionQuality: 0.6) else {
            throw CameraServiceError.invalidImage
        }

        let base64Image = imageData.base64EncodedString()

        let requestBody: [String: Any] = [
            "model": "gpt-4-vision-preview",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": "Analyze this food image and provide nutritional information. Return the response in the following JSON format: {\"foodItems\": [{\"name\": \"food name\", \"calories\": number, \"proteins\": number, \"carbs\": number, \"fats\": number}], \"totalCalories\": number, \"confidence\": number}"
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 500
        ]

        guard let url = URL(string: baseURL) else {
            throw CameraServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
            let apiResponse = try decoder.decode(OpenAIResponse.self, from: data)

            guard let content = apiResponse.choices.first?.message.content,
                  let jsonData = content.data(using: .utf8),
                  let visionResponse = try? decoder.decode(VisionAPIResponse.self, from: jsonData) else {
                throw CameraServiceError.decodingError
            }

            return visionResponse
        } catch {
            throw CameraServiceError.decodingError
        }
    }
}

// MARK: - Error Types
enum CameraServiceError: LocalizedError {
    case invalidImage
    case invalidURL
    case invalidResponse
    case apiError(statusCode: Int, data: Data)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "Failed to process the image"
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .apiError(let statusCode, let data):
            if let errorMessage = String(data: data, encoding: .utf8) {
                return "API Error (\(statusCode)): \(errorMessage)"
            }
            return "API Error (\(statusCode))"
        case .decodingError:
            return "Failed to decode the response"
        }
    }
}

// MARK: - Response Types
struct OpenAIResponse: Codable {
    let choices: [Choice]

    struct Choice: Codable {
        let message: Message
    }

    struct Message: Codable {
        let content: String
    }
}
