//
//  UserSettings.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Foundation
import SwiftData

@Model
final class UserSettings {
    var id: UUID
    var userName: String
    var calorieGoal: Int
    var proteinGoal: Int
    var carbsGoal: Int
    var fatsGoal: Int
    
    init(
        id: UUID = UUID(),
        userName: String = "",
        calorieGoal: Int = 2000,
        proteinGoal: Int = 100,
        carbsGoal: Int = 250,
        fatsGoal: Int = 70
    ) {
        self.id = id
        self.userName = userName
        self.calorieGoal = calorieGoal
        self.proteinGoal = proteinGoal
        self.carbsGoal = carbsGoal
        self.fatsGoal = fatsGoal
    }
}
