//
//  SettingsView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage(AppStorageKeys.username) private var username: String = ""
    @State private var isVisible = true
    @State private var showGoalSettings = false
    @State private var viewModel: SettingsViewModel? = nil
    @State private var showLogoutAlert = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Constants.usernameLabel)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("@\(viewModel?.displayName ?? "")")
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Section {
                    NavigationLink {
                        GoalSettingsView()
                    } label: {
                        HStack {
                            Image(systemName: "target")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            Text(Constants.setGoalsButtonTitle)
                        }
                    }
                } header: {
                    Text(Constants.goalsSectionHeader)
                } footer: {
                    Text(Constants.goalsSectionFooter)
                }
                
                Section {
                    Button(role: .destructive) {
                        showLogoutAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .frame(width: 24)
                            Text(Constants.logoutButtonTitle)
                        }
                    }
                } header: {
                    Text(Constants.accountSectionHeader)
                } footer: {
                    Text(Constants.accountSectionFooter)
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.4), value: isVisible)
            .overlay {
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.ultraThinMaterial)
                }
            }
            .onAppear {
                if viewModel == nil {
                    let binding = Binding.appStorage(AppStorageKeys.username, default: "")
                    viewModel = SettingsViewModel(username: binding, context: modelContext)
                }
            }
            .alert(Constants.Alerts.logoutTitle, isPresented: $showLogoutAlert) {
                Button(Constants.Alerts.cancel, role: .cancel) {}
                Button(Constants.Alerts.confirmLogout, role: .destructive) {
                    performLogout()
                }
            } message: {
                Text(Constants.Alerts.logoutMessage)
            }
        }
    }
    
    private func performLogout() {
        withAnimation {
            isLoading = true
        }
        
        Task {
            do {
                try await Task.sleep(for: .milliseconds(500)) // Simulate network delay
                try await viewModel?.logout()
                withAnimation {
                    isVisible = false
                }
            } catch {
                // Handle error if needed
            }
            
            withAnimation {
                isLoading = false
            }
        }
    }
    
    private enum Constants {
        static let usernameLabel = "Username"
        static let setGoalsButtonTitle = "Nutrition Goals"
        static let logoutButtonTitle = "Log Out"
        static let navigationTitle = "Settings"
        
        static let goalsSectionHeader = "Nutrition"
        static let goalsSectionFooter = "Set your daily nutrition goals to track your progress"
        static let accountSectionHeader = "Account"
        static let accountSectionFooter = "Logging out will clear all your data"
        
        enum Alerts {
            static let logoutTitle = "Log Out"
            static let logoutMessage = "Are you sure you want to log out? This will clear all your data."
            static let cancel = "Cancel"
            static let confirmLogout = "Log Out"
        }
    }
}
