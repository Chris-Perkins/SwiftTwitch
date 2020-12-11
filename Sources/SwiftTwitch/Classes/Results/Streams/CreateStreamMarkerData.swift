//
//  CreateStreamMarkerData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/30/18.
//

import Foundation

/// `CreateStreamMarkerData` contains information about a Stream Marker that was created via the
/// `Create Stream Marker` API call of the New Twitch API.
public struct CreateStreamMarkerData: Codable {

    /// `streamMarkerData` holds data about the stream marker that was created.
    public let streamMarkerData: [UnpostedStreamMarkerData]

}
