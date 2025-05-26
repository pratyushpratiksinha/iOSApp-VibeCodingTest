//
//  MacroCard.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import SwiftUI

struct MacroCard: View {
    @Binding var progress: Double
    @Binding var title: String
    @Binding var subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            CircularProgressBar(progress: progress, image: icon, color: color, lineWidth: 4)
                .frame(width: 32, height: 32)
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}
