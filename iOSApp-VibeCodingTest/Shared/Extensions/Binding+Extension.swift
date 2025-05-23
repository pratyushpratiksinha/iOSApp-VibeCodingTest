//
//  Binding+Extension.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

extension Binding where Value: Sendable {
    static func appStorage(_ key: String, default value: Value) -> Binding<Value> {
        let defaultValue = value
        return Binding(
            get: {
                UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
            },
            set: {
                UserDefaults.standard.set($0, forKey: key)
            }
        )
    }
}
