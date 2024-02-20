//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by loratech on 20/02/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func toDisplayFormat() -> String {
        guard let date = self.toDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
