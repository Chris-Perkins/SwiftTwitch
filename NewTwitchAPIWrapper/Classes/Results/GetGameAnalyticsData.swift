//
//  GetGameAnalyticsData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/28/18.
//

import Marshal

/// `GetGameAnalyticsData` is a class that is used to provide a robust interface for data
/// received from the `Get Game Analytics` call of the New Twitch API.
public struct GetGameAnalyticsData: Unmarshaling {

    /// `url` specifies the URL that Twitch returned where the analytics report is contained.
    public let url: URL

    /// `gameId` specifies the ID of the game that the report at the specified URL contained in
    /// `url` is being analyzed.
    public let gameId: String

    /// `reportType` specifies the type of report of the report at the specified URL contained in
    /// `url`.
    public let reportType: Twitch.Analytics.AnalyticsType

    /// `startedAt` specifies the date when the extension's attributes analyzation started.
    public let startedAt: Date

    /// `endedAt` specifies the date when the extension's attributed analyzation ended.
    public let endedAt: Date

    /// `paginationToken` defines the token that allows for the pagination of results in the
    /// `Get Extension Analytics` call.
    public let paginationToken: String?

    /// Initializes a `GetExtensionAnalyticsData` object from the input `MarshaledObject`. This will
    /// throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `GetExtensionAnalyticsData` piece from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        url = try object.value(for: Twitch.WebRequestKeys.url)
        gameId = try object.value(for: Twitch.WebRequestKeys.gameId)
        reportType = try object.value(for: Twitch.WebRequestKeys.type)
        startedAt = try object.value(for: Twitch.WebRequestKeys.startedAt)
        endedAt = try object.value(for: Twitch.WebRequestKeys.endedAt)
        paginationToken = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
