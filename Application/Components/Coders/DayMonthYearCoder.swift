//
//  DayMonthYearCoder.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import Foundation

final class DayMonthYearCoder: DateCoder {
    override class var formatter: DateFormatter? {
        let formatter = DateFormatter.dayRequestDateFormat
        formatter.timeZone = TimeZone(identifier: "UTC")!
        return formatter
    }
}
