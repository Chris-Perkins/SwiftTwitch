//
//  MarkedStreamData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `MarkedStreamerData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct MarkedStreamerData: Decodable {

    /// `userId` specifies The ID of the user whose stream was marked.
    public let userId: String

    /// `userName` specifies the login name of the user whose stream was marked.
    public let userName: String

    /// `markedVideos` specifies the videos/streams of the user specified by `userId` and `userName`
    /// that were marked with Stream Markers.
    public let markedVideos: [MarkedVideoData]

}
