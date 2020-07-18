//
//  GetBitsLeaderboardParams.swift
//  SwiftTwitch
//
//  Created by Kevin Romero Peces-Barba on 18/07/2020.
//

import Foundation

/// `GetBitsLeaderboardParams`
public struct GetBitsLeaderboardParams {

    /// Number of results to be returned. (optional)
    ///
    /// Maximum: 100.
    ///
    /// Default: 10.
    let count: Int?
    /// Time period over which data is aggregated (PST time zone). (optional)
    ///
    /// This parameter interacts with `started_at`. Valid values are:
    /// - "day" – 00:00:00 on the day specified in `started_at`, through 00:00:00 on the following day.
    /// - "week" – 00:00:00 on Monday of the week specified in `started_at`, through 00:00:00 on the following Monday.
    /// - "month" – 00:00:00 on the first day of the month specified in `started_at`, through 00:00:00 on the first day of the following month.
    /// - "year" – 00:00:00 on the first day of the year specified in `started_at`, through 00:00:00 on the first day of the following year.
    /// - "all" – The lifetime of the broadcaster's channel. If this is specified (or used by default), `started_at` is ignored.
    let period: Twitch.Bits.Period?
    /// Timestamp for the period over which the returned data is aggregated. (optional)
    ///
    /// If this is not provided, data is aggregated over the current period; e.g., the current day/week/month/year.
    ///
    /// This value is ignored if `period is "all".
    let startedAt: Date?
    /// ID of the user whose results are returned; i.e., the person who paid for the Bits. (optional)
    ///
    /// As long as `count` is greater than 1, the returned data includes additional users, with Bits amounts above and below the user specified by `user_id`.
    ///
    /// If `user_id` is not provided, the endpoint returns the Bits leaderboard data across top users (subject to the value of count).
    let userId: String?

}

extension GetBitsLeaderboardParams: Codable {

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case period = "period"
        case startedAt = "started_at"
        case userId = "user_id"
    }

}
