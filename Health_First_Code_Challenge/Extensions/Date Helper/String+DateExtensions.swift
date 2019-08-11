//
//  String+DateExtensions.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation


extension String {
    // create a formatted date from ISO
    // e.g "MMM d, yyyy hh:mm a"
    // e.g usage addedAt.formattedDate("MMMM d, yyyy")
    public func formatISODateString(dateFormat: String) -> String {
        var formatDate = self
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            formatDate = dateFormatter.string(from: date)
        }
        return formatDate
    }
    
    // Change Date in the form of String to Date format
    public func toDate() -> Date {
        var date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        if let isoDate = isoDateFormatter.date(from: self) {
            date = isoDate
        }
        return date
    }
}
