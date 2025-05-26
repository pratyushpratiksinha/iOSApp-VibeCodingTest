//
//  String+Extension.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 26/05/25.
//

import Foundation

extension String {
    func toDictionary() -> [String: Any]? {
        guard let data = data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    func jsonPayloadAfterPrefix(_ prefix: String) -> String {
        if let range = range(of: prefix) {
            return String(self[range.upperBound...])
        }
        return self
    }

    func extractAffordableMaxToken() -> Int? {
        let pattern = #"can only afford (\d+)"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)

        if let match = regex?.firstMatch(in: self, options: [], range: range),
           let tokenRange = Range(match.range(at: 1), in: self) {
            return Int(self[tokenRange])
        }
        return nil
    }
}
