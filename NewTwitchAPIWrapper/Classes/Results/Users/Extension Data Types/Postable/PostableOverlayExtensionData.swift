//
//  PostableOverlayExtension.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 1/1/19.
//

import Foundation

/// `PostableOverlayExtensionData` is a value-type that is used for the posting of an Overlay
/// Extension data update to the New Twitch API.
public struct PostableOverlayExtensionData {

    /// `InitializationError` defines the different types of errors that can occur on
    /// initialization.
    ///
    /// - idNil: The `id` found in initialization of an Extension was `nil`.
    /// - versionNil: The `version` found in initialization of an Extension was `nil`.
    public enum InitializationError: Error {
        case idNil
        case versionNil
    }

    /// `id` is the ID of the extension to update.
    public let id: String

    /// `version` is the version of the extension to update.
    public let version: String

    /// `isActive` determines whether or not the extension is currently active
    public let isActive: Bool

    /// Initializes a `PostableOverlayExtension` with the input parameters as properties
    ///
    /// - Parameters:
    ///   - id: The ID of the Extension
    ///   - version: The Version of the Extension
    ///   - isActive: Whether or not the extension should be active
    public init(id: String, version: String, isActive: Bool) {
        self.id = id
        self.version = version
        self.isActive = isActive
    }

    /// Initializes a `PostableOverlayExtension` with the input `receivedData` object to retrieve
    /// data from.
    ///
    /// - Parameter receivedData: The object to transcribe into a `PostableOverlayExtension`
    /// - Throws: If the `id` or `version` of the input class was `nil`.
    public init(withReceivedData receivedData: ReceivedOverlayExtensionData) throws {
        guard let id = receivedData.id else {
            throw InitializationError.idNil
        }
        guard let version = receivedData.version else {
            throw InitializationError.versionNil
        }
        self.init(id: id, version: version, isActive: receivedData.isActive)
    }
}
