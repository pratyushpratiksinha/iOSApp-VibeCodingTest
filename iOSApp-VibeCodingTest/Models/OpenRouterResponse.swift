//
//  OpenRouterResponse.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 26/05/25.
//

import Foundation

struct OpenRouterResponse: Codable {
    let choices: [Choice]

    struct Choice: Codable {
        let message: Message
    }

    struct Message: Codable {
        let content: String
    }
}
