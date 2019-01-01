//
//  ReceivedComponentExtensionData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 1/1/19.
//

import Marshal

/// `ReceivedComponentExtensionData` is a `ReceivedExtensionModel` child that holds information
/// about a Component Extension as referenced by the New Twitch API.
public struct ReceivedComponentExtensionData: Unmarshaling {

    /// `name` specifies the name of the extension.
    public let name: String?

    /// `id` specifies the ID of the extension.
    public let id: String?

    /// `version` specifies the version of the extension.
    public let version: String?

    /// `isActive` specifies if this extension is activated or not.
    public let isActive: Bool

    /// `x` is the x-coordinate of the placement of the extension.
    public let x: Int?

    /// `y` is the y-coordinate of the placement of the extension.
    public let y: Int?

    /// Initializes a `ReceivedComponentExtensionData` object from the input `MarshaledObject`. This
    /// will throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ReceivedComponentExtensionData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        name = try? object.value(for: Twitch.WebRequestKeys.name)
        id = try? object.value(for: Twitch.WebRequestKeys.id)
        version = try? object.value(for: Twitch.WebRequestKeys.name)
        isActive = try object.value(for: Twitch.WebRequestKeys.active)
        x = try? object.value(for: Twitch.WebRequestKeys.x)
        y = try? object.value(for: Twitch.WebRequestKeys.y)
    }
}
