//
//  LoginView.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 23/05/25.
//

import SwiftUI

struct LoginView: View {
    @Bindable var model: LoginViewModel

    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text(Constants.title)
                .font(.largeTitle)
                .bold()

            TextField(Constants.textFieldPlaceholder, text: $model.enteredUsername)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, Constants.horizontalPadding)

            Button(Constants.buttonTitle) {
                model.submit()
            }
            .disabled(!model.canSubmit)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private enum Constants {
        static let title = "Welcome to Vibe Coding Test"
        static let textFieldPlaceholder = "Enter your name"
        static let buttonTitle = "Continue"
        static let verticalSpacing: CGFloat = 24
        static let horizontalPadding: CGFloat = 16
    }
}
