//
//  Coder.Date.swift
//  CenterAPI
//
//  Created by jcc on 2022/12/16.
//

import Foundation

@propertyWrapper
public struct DateStringCoding: Codable {
    public var wrappedValue: Date?
    
    public init(wrappedValue: Date?) {
      self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        guard let dateString = try? container.decode(String.self) else {
            return
        }
        guard let date = Self.dateFormatter.date(from: dateString) else {
            let dateFormat = String(describing: Self.dateFormatter.dateFormat)
            throw DecodingError.dataCorruptedError(in: container, debugDescription:
            "Expected date to be in format `\(dateFormat)`, but `\(dateString) does not fulfill format`")
        }
        self.wrappedValue = date
    }

    private static let dateFormatter: DateFormatter = Self.createDateFormatter()
    private static func createDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone   = TimeZone(secondsFromGMT: 8)
        formatter.locale     = Locale(identifier: "zh_Hans_CN")
        return formatter
    }
    
}

