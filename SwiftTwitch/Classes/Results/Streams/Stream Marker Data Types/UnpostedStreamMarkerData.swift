//
//  StreamMarkerData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `UnpostedStreamMarkerData` is a class that is used to provide a robust interface for stream
/// marker data received from the `Create Stream Marker` call of the New Twitch API. This marker
/// is NOT posted, and therefore it does not have a URL for accessibility.
public struct UnpostedStreamMarkerData: Unmarshaling {

    /// `id` specifies the id of the Stream Marker.
    public let id: String

    /// `creationDate` specifies when the Stream Marker was created.
    public let creationDate: Date

    /// `description` specifies the description of the Stream marker.
    public let description: String?

    /// `secondsPosition` defines the offset of the marker in seconds based on the beginning of the
    /// stream.
    public let secondsPosition: Int

    /// Initializes a `UnpostedStreamMarkerData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `UnpostedStreamMarkerData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        id = try object.value(for: Twitch.WebRequestKeys.id)
        creationDate = try object.value(for: Twitch.WebRequestKeys.createdAt)
        description = try? object.value(for: Twitch.WebRequestKeys.description)
        secondsPosition = try object.value(for: Twitch.WebRequestKeys.positionSeconds)
    }
}
