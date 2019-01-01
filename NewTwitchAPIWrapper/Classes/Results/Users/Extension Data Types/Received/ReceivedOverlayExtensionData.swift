//
//  ReceivedOverlayExtensionData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 1/1/19.
//

import Marshal

/// `ReceivedOverlayExtensionData` is a `ReceivedExtensionModel` child that holds information about
/// an Overlay Extension as referenced by the New Twitch API.
public struct ReceivedOverlayExtensionData: Unmarshaling {

    /// `name` specifies the name of the extension.
    public let name: String?

    /// `id` specifies the ID of the extension.
    public let id: String?

    /// `version` specifies the version of the extension.
    public let version: String?

    /// `isActive` specifies if this extension is activated or not.
    public let isActive: Bool

    /// Initializes a `ReceivedOverlayExtensionData` object from the input `MarshaledObject`. This
    /// will throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ReceivedOverlayExtensionData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        name = try? object.value(for: Twitch.WebRequestKeys.name)
        id = try? object.value(for: Twitch.WebRequestKeys.id)
        version = try? object.value(for: Twitch.WebRequestKeys.name)
        isActive = try object.value(for: Twitch.WebRequestKeys.active)
    }
}
