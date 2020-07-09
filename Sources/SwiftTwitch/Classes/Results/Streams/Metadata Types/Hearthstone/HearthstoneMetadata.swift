//
//  HearthstoneMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `HearthstoneMetadata` is a class that encapsulates all of the information of a Hearthstone's
/// metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct HearthstoneMetadata: Decodable {

    /// The metadata of the broadcaster.
    public let broadcasterMetadata: HearthstonePlayerMetadata

    /// The metadata of the broadcaster's opponent.
    public let opponentMetadata: HearthstonePlayerMetadata

}
