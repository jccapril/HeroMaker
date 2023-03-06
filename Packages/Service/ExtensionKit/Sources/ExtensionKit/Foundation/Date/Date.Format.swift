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
    
    
}
