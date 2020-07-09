//
//  OverwatchPlayerMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `OverwatchPlayerMetadata` is a class that encapsulates the information of a single Overwatch
/// Player's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct OverwatchPlayerMetadata: Unmarshaling {

    /// `heroMetadata` contains the information regarding the hero being used for this player.
    public let heroMetadata: OverwatchHeroMetadata?

    /// Initializes a `OverwatchPlayerMetadata` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a OverwatchPlayerMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        heroMetadata = try? object.value(for: Twitch.WebRequestKeys.hero)
    }
}
