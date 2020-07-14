//
//  OverwatchHeroMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `OverwatchHeroMetadata` is a class that encapsulates the information of a single Overwatch
/// Hero's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct OverwatchHeroMetadata: Codable {

    /// The name of the hero being played.
    public let heroName: String

    /// The name of the ability being used for this hero.
    public let ability: String?

    /// The role of the hero being played.
    public let role: String

}
