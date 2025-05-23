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
}
