//
//  MacroStackEntry.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Foundation
import SwiftUI

struct MacroStackEntry: Identifiable {
    let id = UUID()
    let date: Date
    let macro: String
    let value: Int
    let color: Color
}
