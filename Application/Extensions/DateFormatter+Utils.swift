//
//  DateFormatter+Utils.swift
//  TestNTApp
//
//  Created by Diachenko Ihor on 11.05.2023.
//

import Foundation

extension DateFormatter {
    public static var dayRequestDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter
    }
}
