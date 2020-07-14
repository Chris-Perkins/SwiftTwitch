//
//  CreateStreamMarkerData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `CreateStreamMarkerData` contains information about a Stream Marker that was created via the
/// `Create Stream Marker` API call of the New Twitch API.
public struct CreateStreamMarkerData: Unmarshaling {

    /// `streamMarkerData` holds data about the stream marker that was created.
    public let streamMarkerData: [UnpostedStreamMarkerData]

    /// Initializes a `CreateStreamMarkerData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `CreateStreamMarkerData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        streamMarkerData = try object.value(for: Twitch.WebRequestKeys.data)
    }
}
