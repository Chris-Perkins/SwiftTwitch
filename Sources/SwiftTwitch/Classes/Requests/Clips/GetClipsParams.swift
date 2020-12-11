//
//  GetClipParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetClipParams`
public struct GetClipParams {

    /// ID of the broadcaster for whom clips are returned.
    ///
    /// For a query to be valid, `id` (one or more), `broadcaster_id`, or `game_id` must be specified. You may specify only one of these parameters.
    ///
    /// The number of clips returned is determined by the `first` parameter (default: 20). Results are ordered by view count.
    let broadcasterId: String?
    /// ID of the game for which clips are returned.
    ///
    /// For a query to be valid, `id` (one or more), `broadcaster_id`, or `game_id` must be specified. You may specify only one of these parameters.
    ///
    /// The number of clips returned is determined by the `first` parameter (default: 20). Results are ordered by view count.
    let gameId: String?
    /// ID of the clip(s) being queried.
    ///
    /// For a query to be valid, `id` (one or more), `broadcaster_id`, or `game_id` must be specified. You may specify only one of these parameters.
    let clipId: [String]?

    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// This applies only to queries specifying `broadcaster_id` or `game_id.
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// This applies only to queries specifying `broadcaster_id` or `game_id.
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let before: String?
    /// Ending date/time for returned clips. (optional)
    ///
    /// If this is specified, `started_at also must be specified; otherwise, the time period is ignored.
    let endedAt: Date?
    /// Maximum number of objects to return. (optional)
    ///
    /// Maximum: 100.
    ///
    /// Default: 20.
    let first: Int?
    /// Starting date/time for returned clips. (optional)
    ///
    /// If this is specified, `ended_at` also should be specified; otherwise, the `ended_at` date/time will be 1 week after the started_at value.
    let startedAt: Date?

}

extension GetClipParams: Codable {

    enum CodingKeys: String, CodingKey {
        case broadcasterId = "broadcaster_id"
        case gameId = "game_id"
        case clipId = "id"

        case after = "after"
        case before = "before"
        case endedAt = "ended_at"
        case first = "first"
        case startedAt = "started_at"
    }

}
