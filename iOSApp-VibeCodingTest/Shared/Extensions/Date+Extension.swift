//
//  Date+Extension.swift
//  iOSApp-VibeCodingTest
//
//  Created by Pratyush Pratik Sinha on 24/05/25.
//

import Foundation

extension Date {
    var onlyDate: Date {
        Calendar.current.startOfDay(for: self)
    }
}
