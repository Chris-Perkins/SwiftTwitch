//
//  DictionaryExtensions.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

extension Dictionary {
    
    /// `addValueIfNotNil` is used to add a `Value` to the dictionary if the provided `Value` is not
    /// `nil`. If the value is `nil`, this function will perform no operations.
    ///
    /// - Parameters:
    ///   - value: The `Value` to add if not `nil`
    ///   - key: The key to add `value` to if it is not nil
    internal mutating func addValueIfNotNil(_ value: Value?, toKey key: Key) {
        guard let nonNilValue = value else {
            return
        }
        self[key] = nonNilValue
    }
}

extension Dictionary where Key == String, Value == Any {

    /// Converts the `Dictionary` to its `Data` representation.
    ///
    /// - Returns: The `Data` representation of the `Dictionary`.
    internal func getAsData() -> Data? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self) else {
            return nil
        }
        return jsonData
    }
}
