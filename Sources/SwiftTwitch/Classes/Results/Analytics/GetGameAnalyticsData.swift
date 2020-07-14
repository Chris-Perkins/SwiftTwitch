//
//  GetGameAnalyticsData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/28/18.
//

import Foundation

/// `GetGameAnalyticsData` is a class that is used to provide a robust interface for data
/// received from the `Get Game Analytics` call of the New Twitch API.
public struct GetGameAnalyticsData: Codable {

    /// `reportData` holds the reports returned by the New Twitch API that contain information on
    /// the analytics reports.
    public let reportData: [GameAnalyticsReportData]

    /// `paginationToken` defines the token that allows for the pagination of results in the
    /// `Get Game Analytics` call.
    public let paginationData: PaginationData?

}
