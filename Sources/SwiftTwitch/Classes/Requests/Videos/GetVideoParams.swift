//
//  GetVideoParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetVideoParams` wraps the necessary parameters to perform a request to get videos
public struct GetVideoParams {

    /// ID of the video(s) being queried.
    ///
    /// Limit: 100.
    ///
    /// If this is specified, you cannot use any of the optional parameters.
    ///
    /// Each request must specify one or more video `ids`, one `user_id`, or one `game_id`.
    let ids: [String]?
    /// ID of the user who owns the video.
    ///
    /// Each request must specify one or more video `ids`, one `user_id`, or one `game_id`.
    let userId: String?
    /// ID of the game the video is of.
    ///
    /// Each request must specify one or more video `ids`, one `user_id`, or one `game_id`.
    let gameId: String?

    /// Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let after: String?
    /// Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. (optional)
    ///
    /// The cursor value specified here is from the pagination response field of a prior query.
    let before: String?
    /// Number of values to be returned when getting videos by user or game ID. (optional)
    ///
    /// Limit: 100.
    ///
    /// Default: 20.
    let first: Int?
    /// Language of the video being queried. (optional)
    let language: String?
    /// Period during which the video was created. (optional)
    ///
    /// Valid values: `.all`, `.day`, `.week`, `.month`.
    ///
    /// Default: `.all`.
    let period: Twitch.Videos.Period?
    /// Sort order of the videos. (optional)
    ///
    /// Valid values: `.time`, `.trending`, `.views`.
    ///
    /// Default: `.time`.
    let sortType: Twitch.Videos.SortType?
    /// Type of video. (optional)
    ///
    /// Valid values: `.all`, `.upload`, `.archive`, `.highlight`.
    ///
    /// Default: `.all`.
    let videoType: Twitch.Videos.VideoQueryType?

}

extension GetVideoParams: Codable {

    enum CodingKeys: String, CodingKey {
        case ids = "id"
        case userId = "user_id"
        case gameId = "game_id"
        case after = "after"
        case before = "before"
        case first = "first"
        case language = "language"
        case period = "period"
        case sortType = "sort"
        case videoType = "type"
    }

}
