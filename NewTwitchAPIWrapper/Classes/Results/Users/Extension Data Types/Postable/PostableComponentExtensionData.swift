//
//  PostableComponentExtensionData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 1/1/19.
//

import Foundation

/// `PostableComponentExtensionData` is a value-type that is used for the posting of a Component
/// Extension data update to the New Twitch API.
public struct PostableComponentExtensionData {
    
    /// `InitializationError` defines the different types of errors that can occur on
    /// initialization.
    ///
    /// - idNil: The `id` found in initialization of an Extension was `nil`.
    /// - versionNil: The `version` found in initialization of an Extension was `nil`.
    public enum InitializationError: Error {
        case idNil
        case versionNil
        case xNil
        case yNil
    }
    
    /// `id` is the ID of the extension to update.
    public let id: String
    
    /// `version` is the version of the extension to update.
    public let version: String
    
    /// `isActive` determines whether or not the extension is currently active
    public let isActive: Bool

    /// `x` is the x-coordinate position of the extension's placement.
    public let x: Int

    /// `y` is the y-coordinate position of the extension's placement.
    public let y: Int

    /// Initializes a `PostableComponentExtension` with the input parameters as properties
    ///
    /// - Parameters:
    ///   - id: The ID of the Extension
    ///   - version: The Version of the Extension
    ///   - isActive: Whether or not the extension should be active
    public init(id: String, version: String, isActive: Bool, x: Int, y: Int) {
        self.id = id
        self.version = version
        self.isActive = isActive
        self.x = x
        self.y = y
    }

    /// Initializes a `PostableComponentExtension` with the input `receivedData` object to retrieve
    /// data from.
    ///
    /// - Parameter receivedData: The object to transcribe into a `PostableComponentExtension`
    /// - Throws: If the `id` or `version` of the input class was `nil`.
    public init(withReceivedData receivedData: ReceivedComponentExtensionData) throws {
        guard let id = receivedData.id else {
            throw InitializationError.idNil
        }
        guard let version = receivedData.version else {
            throw InitializationError.versionNil
        }
        guard let x = receivedData.x else {
            throw InitializationError.xNil
        }
        guard let y = receivedData.y else {
            throw InitializationError.yNil
        }
        self.init(id: id, version: version, isActive: receivedData.isActive, x: x, y: y)
    }
}
