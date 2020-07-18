//
//  GetFollowedStreamsData.swift
//  SwiftTwitch
//
//  Created by Nick Potts on 09/20/19.

import Foundation

/// `GetFollowedStreamsData` is a class that is used to provide a robust interface for data received
/// from the `Get Followed Streams` call of the v5 Twitch API.
public struct GetFollowedStreamsData: Codable {
    
    /// `streamData` specifies the data of the streams that was retrieved from the API call.
    public let streamData: [StreamData]
    
    /// `total` defines the token that displays the total number of streams from the
    /// `Get Followed Streams` call.
    public let total: Int

}
