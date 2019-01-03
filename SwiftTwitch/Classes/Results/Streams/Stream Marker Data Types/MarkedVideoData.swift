//
//  MarkedVideoData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `MarkedVideoData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct MarkedVideoData: Unmarshaling {

    /// The ID of the video who was marked by `markers`.
    public let videoId: String

    /// `markers` specifies the stream markers of the stream specified by `videoId`.
    public let markers: [PostedStreamMarkerData]

    /// Initializes a `MarkedVideoData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `MarkedVideoData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        videoId = try object.value(for: Twitch.WebRequestKeys.videoId)
        markers = try object.value(for: Twitch.WebRequestKeys.markers)
    }
}
