//
//  GetBitsLeaderboardData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

/// `GetBitsLeaderboardData` is a class that is used to provide a robust interface for data received
/// from the `Get Bits Leaderboard Analytics` call of the New Twitch API.
public struct GetBitsLeaderboardData: Decodable {

    /// `userData` specifies the received data from `Get Bits Leaderboard Data` API calls. This
    /// data will contain the users with ranks in descending order.
    public let userData: [GetBitsLeaderboardUserData]

    /// `total` specifies the total number of users in the Bits leaderboard.
    public let total: Int

    /// `startedAt` specifies the date when the extension's attributes analyzation started.
    public let startedAt: Date?

    /// `endedAt` specifies the date when the extension's attributed analyzation ended.
    public let endedAt: Date?

}
