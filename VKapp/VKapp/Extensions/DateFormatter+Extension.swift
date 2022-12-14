// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension DateFormatter {
    // MARK: - Public Methods

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
