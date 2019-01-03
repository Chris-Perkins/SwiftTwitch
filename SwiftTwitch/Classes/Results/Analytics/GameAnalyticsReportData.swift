//
//  GameAnalyticsReportData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal

/// `GameAnalyticsReportData` holds
public struct GameAnalyticsReportData: Unmarshaling {

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

    /// Initializes a `GameAnalyticsReportData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetExtensionAnalyticsReportData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        url = try object.value(for: Twitch.WebRequestKeys.url)
        gameId = try object.value(for: Twitch.WebRequestKeys.gameId)
        reportType = try object.value(for: Twitch.WebRequestKeys.type)
        startedAt = try? object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.startedAt)")
        endedAt = try? object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.endedAt)")
    }
}
