//
//  CustomTextFieldStyle.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 03/06/25.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, Constants.textFieldPadding)
            .padding(.vertical, Constants.textFieldVerticalPadding)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
    }
    
    private enum Constants {
        static let textFieldPadding: CGFloat = 16
        static let textFieldVerticalPadding: CGFloat = 12
    }
}
