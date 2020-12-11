//
//  HearthstonePlayerMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `HearthstonePlayerMetadata` is a class that encapsulates the information of a single Hearthstone
/// Player's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstonePlayerMetadata: Codable {

    /// `heroMetadata` contains the information regarding the hero being used for this player.
    public let heroMetadata: HearthstoneHeroMetadata?

}

