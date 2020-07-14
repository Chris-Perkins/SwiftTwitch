//
//  HearthstoneHeroMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Marshal

/// `HearthstoneHeroMetadata` is a class that encapsulates the information of a single Hearthstone
/// Hero's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstoneHeroMetadata: Unmarshaling {

    /// The name of the class being played for this hero.
    public let className: String

    /// The type of the hero being played.
    public let heroType: String

    /// The name of the hero being played.
    public let heroName: String

    /// Initializes a `HearthstoneHeroMetadata` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `HearthstoneHeroMetadata` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        className = try object.value(for: Twitch.WebRequestKeys.classKey)
        heroType = try object.value(for: Twitch.WebRequestKeys.type)
        heroName = try object.value(for: Twitch.WebRequestKeys.name)
    }
}

