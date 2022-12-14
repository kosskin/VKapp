// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Extension for confert TimeInterval in String with needly format
extension DateFormatter {
    static func convert(timestamp: TimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date as Date)
        return String(localDate)
    }
}
