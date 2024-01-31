//
//  DateExtension.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import Foundation

extension Date {
    static func convertTimestampToDateTime(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp) / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateTime = dateFormatter.string(from: date)
        return formattedDateTime
    }
}
