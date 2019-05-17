//
//  Date+.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//
import Foundation

extension Calendar {
    static var jpCalendar: Calendar = {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
            calendar.timeZone = timeZone
        }
        calendar.locale = Locale(identifier: "en_JP")
        return calendar
    }()
}

extension Date {
    enum Formatter {
        case releaseDate
        
        var format: String {
            switch self {
            case .releaseDate:
                return "yyyy-mm-dd"
            }
        }
        
        var instance: DateFormatter {
            return DateFormatter().then {
                $0.dateFormat = format
                $0.calendar = Calendar.jpCalendar
                $0.locale = Calendar.jpCalendar.locale
                $0.timeZone = Calendar.jpCalendar.timeZone
            }
        }
    }
}

extension DateFormatter {
    static func from(format: String) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format
            $0.calendar = Calendar.jpCalendar
            $0.locale = Calendar.jpCalendar.locale
            $0.timeZone = Calendar.jpCalendar.timeZone
        }
    }
}

extension Date {
    var releaseDateString: String {
        return self.toString(format: Formatter.releaseDate)
    }

}

extension Date {
    
    func toString(format: Formatter) -> String {
        return toString(format: format.instance)
    }
    
    func toString(format: DateFormatter) -> String {
        return format.string(from: self)
    }
}

