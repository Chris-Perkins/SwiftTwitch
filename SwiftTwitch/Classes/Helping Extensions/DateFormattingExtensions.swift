//
//  DateFormattingExtensions.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation
import Marshal

// MARK: - Base Extension

extension Date {
    
    /// `zuluDateFormatter` is a lazily-instantiated date formatter whose time zone is set to UTC
    /// and whose format is RFC 3339.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss'Z'"
    private static var zuluDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        
        return dateFormatter
    }()
    
    /// `convertZuluDateStringToLocalDate` takes in a RFC 3339 Date `String` from the UTC time zone
    /// and converts it to a `Date` appropriate for the current time zone.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    ///
    /// - Parameter dateString: The date string to convert
    /// - Returns: The date that was converted to from the input `dateString`
    internal static func convertZuluDateStringToLocalDate(_ dateString: String) -> Date? {
        return zuluDateFormatter.date(from: dateString)
    }
    
    /// `convertDateToZuluString` takes in a Date and converts it to an RFC 3339 formatted String in
    /// the UTC TimeZone.
    ///
    /// The RFC 3339 format is "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    ///
    /// - Parameter date: The `Date` to convert to a Zulu time `String`
    /// - Returns:
    internal static func convertDateToZuluString(_ date: Date) -> String {
        return zuluDateFormatter.string(from: date)
    }
}

// MARK: - ValueType Extension

extension Date: ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        guard let date = Date.convertZuluDateStringToLocalDate(dateString) else {
            throw MarshalError.typeMismatch(expected: "Zulu date string", actual: dateString)
        }
        return date
    }
}
