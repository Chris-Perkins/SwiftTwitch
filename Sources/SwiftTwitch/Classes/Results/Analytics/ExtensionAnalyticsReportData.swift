//
//  ExtensionAnalyticsReportData.swift
//  SwiftTwitch
//
//  Created by Christopher Perkins on 12/29/18.
//

import Foundation


/// `ExtensionAnalyticsReportData` holds data about the different reports that are returned by
/// Twitch. This will contain the URL, the ID of the extension being reported on, and other details
/// about the report.
public struct ExtensionAnalyticsReportData: Decodable {

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

}
