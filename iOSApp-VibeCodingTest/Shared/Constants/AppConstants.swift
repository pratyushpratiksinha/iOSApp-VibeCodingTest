//
//  Constants.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 02/06/25.
//

import Foundation
import SwiftUI

enum AppConstants {
    enum Nutrients {
        enum Icons {
            static let caloriesFilled = "flame.fill"
            static let proteinFilled = "figure.strengthtraining.traditional"
            static let carbsFilled = "leaf.fill"
            static let fatsFilled = "drop.fill"
            
            static let calories = "flame"
            static let protein = "figure.strengthtraining.traditional"
            static let carbs = "leaf"
            static let fats = "drop"
            
            static var caloriesDefault: String { caloriesFilled }
            static var proteinDefault: String { proteinFilled }
            static var carbsDefault: String { carbsFilled }
            static var fatsDefault: String { fatsFilled }
        }
        
        enum Colors {
            static let calories = Color.orange
            static let protein = Color.blue
            static let carbs = Color.green
            static let fats = Color.purple
            
            static let caloriesMuted = Color.orange.opacity(0.6)
            static let proteinMuted = Color.blue.opacity(0.6)
            static let carbsMuted = Color.green.opacity(0.6)
            static let fatsMuted = Color.purple.opacity(0.6)
        }
        
        enum Units {
            static let calories = "kcal"
            static let protein = "g"
            static let carbs = "g"
            static let fats = "g"
        }
        
        enum Titles {
            static let calories = "Calories"
            static let caloriesOver = "Calories over"
            static let caloriesLeft = "Calories left"
            static let protein = "Protein"
            static let carbs = "Carbs"
            static let carbohydrates = "Carbohydrates"
            static let fats = "Fats"
            static let overSuffix = "over"
            static let leftSuffix = "left"
        }
        
        enum MinValue {
            static let Calories = 1000
            static let Macro = 10
        }
        
        enum MaxValue {
            static let Calories = 10000
            static let Protein = 500
            static let Carbs = 1000
            static let Fats = 300
        }
    }
    
    enum UI {
        static let buttonHeight: CGFloat = 40
        static let horizontalPadding: CGFloat = 16
        static let buttonTopPadding: CGFloat = 16
        static let inputFieldHeight: CGFloat = 48
    }
}
