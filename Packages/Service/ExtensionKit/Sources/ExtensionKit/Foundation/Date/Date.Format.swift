//
//  File.swift
//  
//
//  Created by jcc on 2023/3/3.
//

import Foundation


public extension Date {
    
    private static var dateFormatter = DateFormatter()

    func format(_ dateFormat: String? = "yyyy-MM-dd'T'HH:mm:ssXXX") -> String? {
        Self.dateFormatter.dateFormat = dateFormat
        return Self.dateFormatter.string(from: self)
    }
    
    static func from(_ from: String?, dateFormat: String? = "yyyy-MM-dd'T'HH:mm:ss.SSXXX") -> Date? {
        guard let from = from else { return nil }
        Self.dateFormatter.dateFormat = dateFormat
        return Self.dateFormatter.date(from: from)
    }
    
    
}
