//
//  SettingsView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var model: SettingsViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Constants.profileHeader)) {
                    Text("\(Constants.usernameLabel) \(model.displayName)")
                }

                Section {
                    Button(role: .destructive) {
                        model.logout()
                    } label: {
                        Text(Constants.logoutButtonTitle)
                    }
                }
            }
            .navigationTitle(Constants.navigationTitle)
        }
    }

    private enum Constants {
        static let profileHeader = "Profile"
        static let usernameLabel = "Username:"
        static let logoutButtonTitle = "Logout"
        static let navigationTitle = "Settings"
    }
}
