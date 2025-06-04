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
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    private let viewModel: LoginViewModel
    
    init() {
        let usernameBinding = Binding.appStorage(AppStorageKeys.username, default: "")
        viewModel = LoginViewModel(username: usernameBinding)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.verticalSpacing) {
                Spacer(minLength: Constants.spacerMinLength)

                VStack(spacing: Constants.titleSpacing) {
                    Image("vibe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.logoSize, height: Constants.logoSize)
                        .foregroundColor(.primary)
                        .symbolEffect(.bounce, options: .repeating, value: isVisible)
                        .clipShape(Circle())
                    
                    Text(Constants.title)
                        .font(.system(size: Constants.titleSize, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, Constants.topPadding)
                
                Spacer(minLength: Constants.spacerMinLength)
                
                VStack(spacing: Constants.inputSpacing) {
                    TextField(Constants.textFieldPlaceholder, text: $enteredUsername)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .submitLabel(.done)
                        .onSubmit {
                            submitIfValid()
                        }
                    
                    if !enteredUsername.isEmpty {
                        Text(Constants.usernameRequirements)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, Constants.horizontalPadding)
                    }
                }
                .padding(.horizontal, Constants.horizontalPadding)
                
                Button(action: submitIfValid) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                                .padding(.trailing, 8)
                        }
                        Text(Constants.buttonTitle)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: Constants.buttonHeight)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValidInput || isLoading)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.top, Constants.buttonTopPadding)
                
                Spacer(minLength: Constants.spacerMinLength)
            }
            .padding(.horizontal)
        }
        .scrollDismissesKeyboard(.interactively)
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .opacity(isVisible ? 1 : 0)
        .animation(.easeInOut(duration: 0.4), value: isVisible)
        .alert(Constants.errorTitle, isPresented: $showError) {
            Button(Constants.errorButtonTitle, role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private var isValidInput: Bool {
        let trimmed = enteredUsername.trimmingCharacters(in: .whitespaces)
        return !trimmed.isEmpty && trimmed.count >= Constants.minUsernameLength
    }
    
    private func submitIfValid() {
        guard isValidInput else { return }
        
        withAnimation {
            isLoading = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            do {
                try viewModel.validateUsername(enteredUsername)
                withAnimation {
                    isVisible = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    viewModel.submit(name: enteredUsername)
                }
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
            
            withAnimation {
                isLoading = false
            }
        }
    }
    
    private enum Constants {
        static let title = "Welcome to Vibe"
        static let textFieldPlaceholder = "Enter your name"
        static let buttonTitle = "Login"
        static let errorTitle = "Invalid Username"
        static let errorButtonTitle = "OK"
        static let usernameRequirements = "Username must be at least 3 characters long"
        
        static let verticalSpacing: CGFloat = 32
        static let titleSpacing: CGFloat = 16
        static let inputSpacing: CGFloat = 8
        static let horizontalPadding: CGFloat = 24
        static let topPadding: CGFloat = 48
        static let buttonTopPadding: CGFloat = 16
        static let buttonHeight: CGFloat = 40
        static let logoSize: CGFloat = 80
        static let titleSize: CGFloat = 28
        static let minUsernameLength = 3
        static let spacerMinLength: CGFloat = 40
        static let textFieldPadding: CGFloat = 16
    }
}
