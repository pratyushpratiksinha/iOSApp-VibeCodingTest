//
//  MainTabView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Constants.homeTabTitle, systemImage: Constants.homeTabIcon)
                }

            SettingsView()
                .tabItem {
                    Label(Constants.settingsTabTitle, systemImage: Constants.settingsTabIcon)
                }
        }
    }

    private enum Constants {
        static let homeTabTitle = "Home"
        static let homeTabIcon = "house"

        static let settingsTabTitle = "Settings"
        static let settingsTabIcon = "gear"
    }
}
