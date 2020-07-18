//
//  CreateClipParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `CreateClipParams`
public struct CreateClipParams {

    /// ID of the stream from which the clip will be made. (required)
    let broadcasterId: String
    /// If false, the clip is captured from the live stream when the API is called; otherwise, a delay is added before the clip is captured (to account for the brief delay between the broadcaster’s stream and the viewer’s experience of that stream). (optional)
    ///
    /// Default: false.
    let hasDelay: Bool?

}

extension CreateClipParams: Codable {

    enum CodingKeys: String, CodingKey {
        case broadcasterId = "broadcaster_id"
        case hasDelay = "has_delay"
    }

}
