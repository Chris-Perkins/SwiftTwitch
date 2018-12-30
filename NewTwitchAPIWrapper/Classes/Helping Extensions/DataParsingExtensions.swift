//
//  DataParsingExtensions.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

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
