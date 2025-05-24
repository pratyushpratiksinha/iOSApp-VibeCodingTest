//
//  MacroEntry.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Foundation
import SwiftUI

struct MacroEntry: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let value: Int
    let color: Color
}
