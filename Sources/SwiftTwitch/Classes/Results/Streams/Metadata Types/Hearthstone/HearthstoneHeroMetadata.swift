//
//  HearthstoneHeroMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `HearthstoneHeroMetadata` is a class that encapsulates the information of a single Hearthstone
/// Hero's metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstoneHeroMetadata: Decodable {

    /// The name of the class being played for this hero.
    public let className: String

    /// The type of the hero being played.
    public let heroType: String

    /// The name of the hero being played.
    public let heroName: String

}

