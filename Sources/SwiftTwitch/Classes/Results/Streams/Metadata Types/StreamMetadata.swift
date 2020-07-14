//
//  StreamMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `StreamMetadata` is a class that encapsulates all of the information of a single returned stream
/// from the returned array of Stream metadata from the New Twitch API's `Streams` methods.
public struct StreamMetadata: Unmarshaling {

    /// `streamerId` specifies the ID of the streamer.
    public let streamerId: String

    /// `streamerUserName` specifies the username of the streamer.
    public let streamerUserName: String

    /// `gameId` specifies the ID of the game being streamed. `nil` if the streamer is not playing
    /// a game.
    public let gameId: String?

    /// The metadata for Overwatch. `nil` if the game is not Overwatch.
    public let overwatchMetadata: OverwatchMetadata?

    /// The metadata for Hearthstone. `nil` if the game is not Hearthstone.
    public let hearthstoneMetadata: HearthstoneMetadata?

    /// Initializes a `StreamMetadata` object from the input `MarshaledObject`. This will throw if
    /// there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `StreamMetadata` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        streamerId = try object.value(for: Twitch.WebRequestKeys.userId)
        streamerUserName = try object.value(for: Twitch.WebRequestKeys.userName)
        gameId = try? object.value(for: Twitch.WebRequestKeys.gameId)
        overwatchMetadata = try? object.value(for: Twitch.WebRequestKeys.overwatch)
        hearthstoneMetadata = try? object.value(for: Twitch.WebRequestKeys.hearthstone)
    }
}
