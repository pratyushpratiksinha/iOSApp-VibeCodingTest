//
//  AppConfig.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 26/05/25.
//

import Foundation

enum AppConfig {
    static var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL not found in Info.plist")
        }
        return url
    }

    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "OPENROUTER_API_KEY") as? String else {
            fatalError("OPENROUTER_API_KEY not found in Info.plist")
        }
        return key
    }
}
