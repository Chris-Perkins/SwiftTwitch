//
//  StreamMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `StreamMetadata` is a class that encapsulates all of the information of a single returned stream
/// from the returned array of Stream metadata from the New Twitch API's `Streams` methods.
public struct StreamMetadata: Codable {

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

}
