//
//  MarkedVideoData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `MarkedVideoData` is a class that is used to provide a robust interface for data received
/// from the `Get Streams` call of the New Twitch API.
public struct MarkedVideoData: Decodable {

    /// The ID of the video who was marked by `markers`.
    public let videoId: String

    /// `markers` specifies the stream markers of the stream specified by `videoId`.
    public let markers: [PostedStreamMarkerData]

}
