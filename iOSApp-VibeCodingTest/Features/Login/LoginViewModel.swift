//
//  LoginViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

final class LoginViewModel {
    let username: Binding<String>

    init(username: Binding<String>) {
        self.username = username
    }

    func submit(name: String) {
        username.wrappedValue = name.trimmingCharacters(in: .whitespaces)
    }

    func validateUsername(_ username: String) throws {
        let trimmed = username.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            throw ValidationError.emptyUsername
        }
        if trimmed.count < 3 {
            throw ValidationError.tooShort
        }
    }
    
    enum ValidationError: LocalizedError {
        case emptyUsername
        case tooShort
        
        var errorDescription: String? {
            switch self {
            case .emptyUsername:
                return "Username cannot be empty"
            case .tooShort:
                return "Username must be at least 3 characters long"
            }
        }
    }
}
