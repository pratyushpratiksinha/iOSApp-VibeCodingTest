//
//  FloatingActionButton.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct FloatingActionButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: Constants.plusIcon)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }

    private enum Constants {
        static let plusIcon = "plus"
    }
}
