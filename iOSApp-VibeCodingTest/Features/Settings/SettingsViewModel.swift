//
//  SettingsViewModel.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import Foundation
import SwiftUI

@Observable
final class SettingsViewModel {
    @AppStorage(AppStorageKeys.username) var username: String = ""

    var displayName: String {
        username
    }

    func logout() {
        username = ""
    }
}
