//
//  Date+Format.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation

extension Date {
    var relativeDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: self, relativeTo: Date.now)
    }
}

extension DateFormatter {
    static var apiFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }
}
