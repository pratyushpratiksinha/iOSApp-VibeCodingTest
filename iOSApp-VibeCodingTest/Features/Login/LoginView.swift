//
//  LoginView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct LoginView: View {
    @AppStorage(AppStorageKeys.username) private var username: String = ""
    @State private var enteredUsername: String = ""
    @State private var isVisible = true
    private let viewModel: LoginViewModel

    init() {
        let usernameBinding = Binding.appStorage(AppStorageKeys.username, default: "")
        self.viewModel = LoginViewModel(username: usernameBinding)
    }

    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text(Constants.title)
                .font(.largeTitle)
                .bold()

            TextField(Constants.textFieldPlaceholder, text: $enteredUsername)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, Constants.horizontalPadding)
            
            Button(Constants.buttonTitle) {
                withAnimation {
                    isVisible = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    viewModel.submit(name: enteredUsername)
                }
            }
            .disabled(enteredUsername.trimmingCharacters(in: .whitespaces).isEmpty)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .opacity(isVisible ? 1 : 0)
        .animation(.easeInOut(duration: 0.4), value: isVisible)
    }

    private enum Constants {
        static let title = "Welcome to Vibe Coding Test"
        static let textFieldPlaceholder = "Enter your name"
        static let buttonTitle = "Continue"
        static let verticalSpacing: CGFloat = 24
        static let horizontalPadding: CGFloat = 16
    }
}
