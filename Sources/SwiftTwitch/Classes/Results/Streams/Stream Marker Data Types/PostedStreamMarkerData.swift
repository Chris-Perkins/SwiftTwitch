//
//  PostedStreamMarkerData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `PostedStreamMarkerData` is a class that is used to provide a robust interface for stream
/// marker data received from the `Get Stream Marker` call of the New Twitch API. This marker
/// is posted, and therefore it can be accessed via a URL for accessibility.
public struct PostedStreamMarkerData: Codable {

    /// `url` specifies the URL where the marker can be accessed from.
    public let url: URL

    /// `id` specifies the id of the Stream Marker.
    public let id: String

    /// `creationDate` specifies when the Stream Marker was created.
    public let creationDate: Date

    /// `description` specifies the description of the Stream marker.
    public let description: String?

    /// `secondsPosition` defines the offset of the marker in seconds based on the beginning of the
    /// stream.
    public let secondsPosition: Int

}
