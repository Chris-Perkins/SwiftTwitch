//
//  GameAnalyticsReportData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation

/// `GameAnalyticsReportData` holds
public struct GameAnalyticsReportData: Codable {

    /// `url` specifies the URL that Twitch returned where the analytics report is contained.
    public let url: URL

    /// `gameId` specifies the ID of the game that the report at the specified URL contained in
    /// `url` is being analyzed.
    public let gameId: String

    /// `reportType` specifies the type of report of the report at the specified URL contained in
    /// `url`.
    public let reportType: Twitch.Analytics.AnalyticsType

    /// `startedAt` specifies the date when the extension's attributes analyzation started.
    public let startedAt: Date?

    /// `endedAt` specifies the date when the extension's attributed analyzation ended.
    public let endedAt: Date?

}
