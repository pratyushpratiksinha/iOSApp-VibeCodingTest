//
//  SettingsViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

final class SettingsViewModel {
    @Binding var username: String

    init(username: Binding<String>) {
        self._username = username
    }

    var displayName: String {
        username
    }

    func logout() {
        username = ""
    }
}
