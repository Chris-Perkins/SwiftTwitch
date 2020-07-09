//
//  GetBitsLeaderboardUserData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

/// `GetBitsLeaderboardUserData` is a class that holds information about a single user from the
/// New Twitch API `Get Bits Leaderboard` call.
public struct GetBitsLeaderboardUserData: Decodable {

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

}
