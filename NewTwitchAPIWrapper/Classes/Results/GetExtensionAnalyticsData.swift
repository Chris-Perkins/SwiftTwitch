//
//  GetExtensionAnalyticsData.swift
//  NewTwitchAPIWrapper
//
//  Created by Christopher Perkins on 12/28/18.
//

import Marshal

/// `GetExtensionAnalyticsData` is a class that is used to provide a robust interface for data
/// received from the `Get Extension Analytics` call of the New Twitch API.
public struct GetExtensionAnalyticsData: Unmarshaling {

    /// `url` specifies the URL that Twitch returned where the analytics report is contained.
    public let url: URL

    /// `extensionId` specifies the ID of the extension that the report at the specified URL
    /// contained in `url` is being analyzed.
    public let extensionId: String

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
        extensionId = try object.value(for: Twitch.WebRequestKeys.extensionId)
        reportType = try object.value(for: Twitch.WebRequestKeys.type)
        startedAt = try object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.startedAt)")
        endedAt = try object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.endedAt)")
        paginationToken = try? object.value(for: Twitch.WebRequestKeys.pagination)
    }
}
