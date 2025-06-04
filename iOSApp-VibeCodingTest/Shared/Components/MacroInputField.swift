//
//  MacroInputField.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 02/06/25.
//

import SwiftUI

enum NutrientField: Hashable {
    case name
    case calories
    case protein
    case carbs
    case fats
}

struct MacroInputField: View {
    let title: String
    @Binding var value: String
    let icon: String
    let color: Color
    let unit: String
    let isFocused: Bool
    let field: NutrientField
    @FocusState.Binding var focusedField: NutrientField?

    private var iconName: String {
        if isFocused {
            switch icon {
            case AppConstants.Nutrients.Icons.caloriesDefault:
                return AppConstants.Nutrients.Icons.caloriesFilled
            case AppConstants.Nutrients.Icons.proteinDefault:
                return AppConstants.Nutrients.Icons.proteinFilled
            case AppConstants.Nutrients.Icons.carbsDefault:
                return AppConstants.Nutrients.Icons.carbsFilled
            case AppConstants.Nutrients.Icons.fatsDefault:
                return AppConstants.Nutrients.Icons.fatsFilled
            default:
                return icon
            }
        } else {
            switch icon {
            case AppConstants.Nutrients.Icons.caloriesDefault:
                return AppConstants.Nutrients.Icons.calories
            case AppConstants.Nutrients.Icons.proteinDefault:
                return AppConstants.Nutrients.Icons.protein
            case AppConstants.Nutrients.Icons.carbsDefault:
                return AppConstants.Nutrients.Icons.carbs
            case AppConstants.Nutrients.Icons.fatsDefault:
                return AppConstants.Nutrients.Icons.fats
            default:
                return icon
            }
        }
    }
    
    private var iconColor: Color {
        if isFocused {
            return color
        } else {
            switch icon {
            case AppConstants.Nutrients.Icons.caloriesDefault:
                return AppConstants.Nutrients.Colors.caloriesMuted
            case AppConstants.Nutrients.Icons.proteinDefault:
                return AppConstants.Nutrients.Colors.proteinMuted
            case AppConstants.Nutrients.Icons.carbsDefault:
                return AppConstants.Nutrients.Colors.carbsMuted
            case AppConstants.Nutrients.Icons.fatsDefault:
                return AppConstants.Nutrients.Colors.fatsMuted
            default:
                return color.opacity(0.6)
            }
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .frame(width: 24)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            TextField(title, text: $value)
                .keyboardType(.numberPad)
                .textFieldStyle(.plain)
                .focused($focusedField, equals: field)
            
            Text(unit)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .frame(height: AppConstants.UI.inputFieldHeight)
    }
}
