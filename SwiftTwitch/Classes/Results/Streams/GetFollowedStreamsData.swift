//
//  GetFollowedStreamsData.swift
//  Marshal
//
//  Created by Nick Potts on 09/20/19.

import Marshal

/// `GetFollowedStreamsData` is a class that is used to provide a robust interface for data received
/// from the `Get Followed Streams` call of the v5 Twitch API.
public struct GetFollowedStreamsData: Unmarshaling {
    
    /// `streamData` specifies the data of the streams that was retrieved from the API call.
    public let streamData: [StreamData]
    
    /// `total` defines the token that displays the total number of streams from the
    /// `Get Followed Streams` call.
    public let total: Int
    
    /// Initializes a `GetStreamsData` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetStreamsData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        streamData = try object.value(for: Twitch.WebRequestKeysV5.streams)
        total = try object.value(for: Twitch.WebRequestKeysV5.total)
    }
}
