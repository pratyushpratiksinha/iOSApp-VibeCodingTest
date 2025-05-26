//
//  SettingsView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKeys.username) private var username: String = ""
    @State private var isVisible = true
    @State private var showGoalSettings = false
    private let viewModel: SettingsViewModel

    init() {
        let binding = Binding.appStorage(AppStorageKeys.username, default: "")
        viewModel = SettingsViewModel(username: binding)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.verticalSpacing) {
                VStack(alignment: .leading, spacing: Constants.innerSpacing) {
                    Text(Constants.profileHeader)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("\(Constants.usernameLabel) @\(viewModel.displayName)")
                        .font(.title3)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(Constants.cornerRadius)

                Button(action: { showGoalSettings = true }) {
                    Text(Constants.setGoalsButtonTitle)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.opacity(0.1))
                        .foregroundColor(.accentColor)
                        .cornerRadius(Constants.cornerRadius)
                }
                .sheet(isPresented: $showGoalSettings) {
                    GoalSettingsView()
                }

                Spacer()

                VStack(spacing: Constants.innerSpacing) {
                    Button(role: .destructive) {
                        withAnimation {
                            isVisible = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            viewModel.logout()
                        }
                    } label: {
                        Text(Constants.logoutButtonTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(Constants.cornerRadius)
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.top, Constants.topPadding)
            .padding(.bottom, Constants.bottomPadding)
            .navigationTitle(Constants.navigationTitle)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.4), value: isVisible)
        }
    }

    private enum Constants {
        static let profileHeader = "Profile"
        static let usernameLabel = "Username:"
        static let setGoalsButtonTitle = "Set Nutrition Goals"
        static let logoutButtonTitle = "Logout"
        static let navigationTitle = "Settings"

        static let topPadding: CGFloat = 32
        static let bottomPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 20
        static let verticalSpacing: CGFloat = 24
        static let innerSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 12
    }
}
