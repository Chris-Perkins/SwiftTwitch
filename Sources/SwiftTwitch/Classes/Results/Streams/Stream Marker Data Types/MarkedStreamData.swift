//
//  MarkedStreamData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `MarkedStreamerData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct MarkedStreamerData: Unmarshaling {

    /// `userId` specifies The ID of the user whose stream was marked.
    public let userId: String

    /// `userName` specifies the login name of the user whose stream was marked.
    public let userName: String

    /// `markedVideos` specifies the videos/streams of the user specified by `userId` and `userName`
    /// that were marked with Stream Markers.
    public let markedVideos: [MarkedVideoData]

    /// Initializes a `MarkedStreamerData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `MarkedStreamerData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        userId = try object.value(for: Twitch.WebRequestKeys.userId)
        userName = try object.value(for: Twitch.WebRequestKeys.userName)
        markedVideos = try object.value(for: Twitch.WebRequestKeys.videos)
    }
}
