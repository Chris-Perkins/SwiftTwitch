//
//  HearthstoneMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `HearthstoneMetadata` is a class that encapsulates all of the information of a Hearthstone's
/// metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstoneMetadata: Unmarshaling {

    /// The metadata of the broadcaster.
    public let broadcasterMetadata: HearthstonePlayerMetadata

    /// The metadata of the broadcaster's opponent.
    public let opponentMetadata: HearthstonePlayerMetadata

    /// Initializes a `HearthstoneMetadata` object from the input `MarshaledObject`. This will throw
    /// if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `HearthstoneMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        broadcasterMetadata = try object.value(for: Twitch.WebRequestKeys.broadcaster)
        opponentMetadata = try object.value(for: Twitch.WebRequestKeys.opponent)
    }
}
