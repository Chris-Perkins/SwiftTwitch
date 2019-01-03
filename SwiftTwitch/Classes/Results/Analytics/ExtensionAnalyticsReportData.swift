//
//  ExtensionAnalyticsReportData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Marshal


/// `ExtensionAnalyticsReportData` holds data about the different reports that are returned by
/// Twitch. This will contain the URL, the ID of the extension being reported on, and other details
/// about the report.
public struct ExtensionAnalyticsReportData: Unmarshaling {

    /// `url` specifies the URL that Twitch returned where the analytics report is contained.
    public let url: URL

    /// `extensionId` specifies the ID of the extension that the report at the specified URL
    /// contained in `url` is being analyzed.
    public let extensionId: String

    /// `reportType` specifies the type of report of the report at the specified URL contained in
    /// `url`.
    public let reportType: Twitch.Analytics.AnalyticsType

    /// `startedAt` specifies the date when the extension's attributes analyzation started.
    public let startedAt: Date?

    /// `endedAt` specifies the date when the extension's attributed analyzation ended.
    public let endedAt: Date?

    /// Initializes a `ExtensionAnalyticsReportData` object from the input `MarshaledObject`.
    /// This will throw if there is missing data from the input `MarshaledObject`.
    ///
    /// - Parameter object: The object to initialize a `ExtensionAnalyticsReportData` object from
    /// - Throws: If data is missing that was expected to be non-`nil`.
    public init(object: MarshaledObject) throws {
        url = try object.value(for: Twitch.WebRequestKeys.url)
        extensionId = try object.value(for: Twitch.WebRequestKeys.extensionId)
        reportType = try object.value(for: Twitch.WebRequestKeys.type)
        startedAt = try? object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.startedAt)")
        endedAt = try? object.value(for:
            "\(Twitch.WebRequestKeys.dateRange).\(Twitch.WebRequestKeys.endedAt)")
    }
}
