//
//  GetStreamMarkersParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetStreamMarkersParams`
public struct GetStreamMarkersParams {

    /// ID of the broadcaster from whose stream markers are returned.
    ///
    /// Only one of `user_id` and `video_id` must be specified.
    let userId: Stirng?
    /// ID of the VOD/video whose stream markers are returned.
    ///
    /// Only one of `user_id` and `video_id` must be specified.
    let videoId: String?

    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let before: String?
    /// Maximum number of objects to return. (optional)
    ///
    /// Maximum: 100.
    ///
    /// Default: 20.
    let first: Int?
}

extension GetStreamMarkersParams: Codable {

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case videoId = "video_id"
        case after = "after"
        case before = "before"
        case first = "first"
    }

}
