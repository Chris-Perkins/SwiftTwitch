//
//  DataParsingExtensions.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

// MARK: - Dictionary Extensions

extension Dictionary where Key == String, Value == Any {
    
    /// Converts the `Dictionary` to its `Data` representation.
    ///
    /// - Returns: The `Data` representation of the `Dictionary`.
    internal func getAsData() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

// MARK: - Data Extensions

extension Data {
    
    /// Gets a String-keyed `Dictionary` object from a `Data` object.
    ///
    /// - Returns: The nullable String-keyed `Dictionary` representation of the `Data`.
    internal func getAsDictionary() -> [String: Any]? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) else {
            return nil
        }
        return jsonObject as? [String: Any]
    }
}
