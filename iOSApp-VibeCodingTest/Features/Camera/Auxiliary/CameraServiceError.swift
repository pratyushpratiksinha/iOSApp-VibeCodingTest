//
//  CameraServiceError.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 26/05/25.
//

import Foundation

enum CameraServiceError: LocalizedError {
    case invalidImage
    case invalidURL
    case invalidResponse
    case apiError(statusCode: Int, data: Data)
    case decodingError
    case noFoodDetected
    case insufficientTokens

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "Failed to process the image"
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid response from server"
        case let .apiError(statusCode, data):
            if let errorMessage = String(data: data, encoding: .utf8) {
                return "API Error (\(statusCode)): \(errorMessage)"
            }
            return "API Error (\(statusCode))"
        case .decodingError:
            return "Failed to decode the response"
        case .noFoodDetected:
            return "I'm unable to analyze food from this image is not a food item. If you have an image of food, feel free to share it"
        case .insufficientTokens:
            return "This request requires more credits, or fewer max_tokens. Please try again with a lower token limit."
        }
    }
}
