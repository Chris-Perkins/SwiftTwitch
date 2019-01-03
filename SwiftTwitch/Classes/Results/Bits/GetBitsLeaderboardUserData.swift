//
//  GetBitsLeaderboardUserData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Marshal

/// `GetBitsLeaderboardUserData` is a class that holds information about a single user from the
/// New Twitch API `Get Bits Leaderboard` call.
public struct GetBitsLeaderboardUserData: Unmarshaling {

    /// `userId` specifies the ID of the user who is being described in this leaderboard data.
    /// This corresponds to the user specified by `username`
    public let userId: String

    /// `userName` specifies the username of the user who is being described in this leaderboard
    /// data. This corresponds to the user specified by `userId`.
    public let userName: String

    /// `rank` specifies the current ranking of the user in this leaderboard.
    public let rank: Int

    /// `score` specifies the current score of the user in this leaderboard.
    public let score: Int

    /// Initializes a `GetExtensionAnalyticsData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetExtensionAnalyticsData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        userId = try object.value(for: Twitch.WebRequestKeys.userId)
        userName = try object.value(for: Twitch.WebRequestKeys.userName)
        rank = try object.value(for: Twitch.WebRequestKeys.rank)
        score = try object.value(for: Twitch.WebRequestKeys.score)
    }
}
