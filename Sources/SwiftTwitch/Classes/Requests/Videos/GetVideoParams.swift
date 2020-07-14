//
//  File.swift
//  
//
//  Created by Kevin Romero Peces-Barba on 14/07/2020.
//

import Foundation

/// `GetVideoParams` wraps the necessary parameters to perform a request to get videos
public struct GetVideoParams: Codable {

    /// `id`: The IDs of the video to be queried. Maximum 100. If this is specified,
    /// then no optional values can be used. Optional if `userId` or `gameId` is specified.
    let id: [String]?

    /// `userId`: The ID of the user to query videos for. Optional if `videoIds` or `gameId`
    /// is specified.
    let userId: String?

    /// `gameId`: The ID of the game to query videos for. Optional if `videoIds` or `userId`
    /// is specified.
    let gameId: String?

    /// `after`: The forward pagination token.
    let after: String?

    /// `before`: The backwards pagination token.
    let before: String?

    /// `first`: The maximum number of videos to return. Maximum: 100. Default: 20.
    let first: Int?

    /// `language`: The language videos must be in to be returned.
    let language: String?

    /// `period`: The period to obtain data for. If this value is `.all`, Default: `.all`.
    let period: Twitch.Videos.Period?

    /// `sortType`: The type of sorting that should occur. Default: `.time`.
    let sortType: Twitch.Videos.SortType?

    /// `videoType`: The type of videos that should be retrieved. Default: `.all`.
    let videoType: Twitch.Videos.VideoQueryType?

}
