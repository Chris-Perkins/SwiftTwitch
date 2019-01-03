//
//  HearthstonePlayerMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `HearthstonePlayerMetadata` is a class that encapsulates the information of a single Hearthstone
/// Player's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstonePlayerMetadata: Unmarshaling {

    /// `heroMetadata` contains the information regarding the hero being used for this player.
    public let heroMetadata: HearthstoneHeroMetadata?

    /// Initializes a `HearthstonePlayerMetadata` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `HearthstonePlayerMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        heroMetadata = try? object.value(for: Twitch.WebRequestKeys.hero)
    }
}

