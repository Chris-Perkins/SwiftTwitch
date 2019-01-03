//
//  OverwatchHeroMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `OverwatchHeroMetadata` is a class that encapsulates the information of a single Overwatch
/// Hero's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct OverwatchHeroMetadata: Unmarshaling {

    /// The name of the hero being played.
    public let heroName: String

    /// The name of the ability being used for this hero.
    public let ability: String?

    /// The role of the hero being played.
    public let role: String

    /// Initializes a `OverwatchHeroMetadata` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `OverwatchHeroMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        heroName = try object.value(for: Twitch.WebRequestKeys.name)
        ability = try? object.value(for: Twitch.WebRequestKeys.ability)
        role = try object.value(for: Twitch.WebRequestKeys.role)
    }
}
