//
//  OverwatchPlayerMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `OverwatchPlayerMetadata` is a class that encapsulates the information of a single Overwatch
/// Player's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct OverwatchPlayerMetadata: Codable {

    /// `heroMetadata` contains the information regarding the hero being used for this player.
    public let heroMetadata: OverwatchHeroMetadata?

}
