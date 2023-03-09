//
//  File.swift
//  
//
//  Created by jcc on 2023/3/3.
//

import Foundation


public extension Date {
    
    static var defaultFormat = "yyyy-MM-dd HH:mm:ss"
    static var format1 = "yyyy-MM-dd'T'HH:mm:ssXXX"
    static var format2 = "yyyy-MM-dd'T'HH:mm:ss.SSXXX"
    
    private static var dateFormatter = DateFormatter()

    func format(_ dateFormat: String? = Self.defaultFormat) -> String? {
        Self.dateFormatter.dateFormat = dateFormat
        return Self.dateFormatter.string(from: self)
    }
    
    static func from(_ from: String?, dateFormat: String? = Self.defaultFormat) -> Date? {
        guard let from = from else { return nil }
        Self.dateFormatter.dateFormat = dateFormat
        return Self.dateFormatter.date(from: from)
    }
    
    
    func getFriendlyDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        if calendar.isDateInTomorrow(self) {
            // 如果日期是今天，则返回当前时间
            dateFormatter.dateFormat = "HH:mm"
            return "明天 " + dateFormatter.string(from: self)
        } else if calendar.isDateInToday(self) {
            // 如果日期是今天，则返回当前时间
            dateFormatter.dateFormat = "HH:mm"
            return "今天 " + dateFormatter.string(from: self)
        } else if calendar.isDateInYesterday(self) {
            // 如果日期是昨天，则返回“昨天”和日期
            dateFormatter.dateFormat = "HH:mm"
            return "昨天 " + dateFormatter.string(from: self)
        }else {
            // 如果日期是其他日期，则只返回日期
            return dateFormatter.string(from: self)
        }
    }
    
}
