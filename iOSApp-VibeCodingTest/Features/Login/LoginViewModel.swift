//
//  LoginViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import SwiftUI

@Observable
final class LoginViewModel {
    @AppStorage(AppStorageKeys.username) var username: String = ""
    var enteredUsername: String = ""

    var canSubmit: Bool {
        !enteredUsername.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func submit() {
        username = enteredUsername.trimmingCharacters(in: .whitespaces)
    }
}
