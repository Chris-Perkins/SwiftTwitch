//
//  ReceivedMobileExtensionData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/31/18.
//

import Marshal

/// `ReceivedMobileExtensionData` is a value-type that holds information about a Mobile Extension as
/// referenced by the New Twitch API.
public struct ReceivedMobileExtensionData: Unmarshaling {

    /// `name` specifies the name of the extension.
    public let name: String?

    /// `id` specifies the ID of the extension.
    public let id: String?

    /// `version` specifies the version of the extension.
    public let version: String?

    /// `isActive` specifies if this extension is activated or not.
    public let isActive: Bool

    /// Initializes a `ReceivedMobileExtensionData` object from the input `MarshaledObject`. This
    /// will throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ReceivedMobileExtensionData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        name = try? object.value(for: Twitch.WebRequestKeys.name)
        id = try? object.value(for: Twitch.WebRequestKeys.id)
        version = try? object.value(for: Twitch.WebRequestKeys.name)
        isActive = try object.value(for: Twitch.WebRequestKeys.active)
    }
}
