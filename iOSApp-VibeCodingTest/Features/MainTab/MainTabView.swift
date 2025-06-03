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
            
            HistoryView()
                .tabItem {
                    Label(Constants.historyTabTitle, systemImage: Constants.historyTabIcon)
                }

            AnalysisView()
                .tabItem {
                    Label(Constants.analysisTabTitle, systemImage: Constants.analysisTabIcon)
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
        
        static let historyTabTitle = "History"
        static let historyTabIcon = "calendar"

        static let analysisTabTitle = "Analysis"
        static let analysisTabIcon = "chart.bar.xaxis"

        static let settingsTabTitle = "Settings"
        static let settingsTabIcon = "gear"
    }
}
