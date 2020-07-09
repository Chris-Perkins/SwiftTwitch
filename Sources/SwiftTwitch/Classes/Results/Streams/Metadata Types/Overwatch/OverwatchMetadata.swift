//
//  OverwatchMetadata.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `OverwatchMetadata` is a class that encapsulates all of the information of a Overwatch's
/// metadata as provided by the New Twitch API's "Get Stream Metadata" API.
public struct OverwatchMetadata: Decodable {
    
    /// The metadata of the broadcaster.
    public let broadcasterMetadata: OverwatchPlayerMetadata

}
